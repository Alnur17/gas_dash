import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_live_track_view.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class StationNearYouView extends StatefulWidget {
  final String deliveryId;
  final String orderId;
  final String userId;
  final String lat;
  final String long;

  const StationNearYouView({
    super.key,
    required this.deliveryId,
    required this.orderId,
    required this.userId,
    required this.lat,
    required this.long,
  });

  @override
  State<StationNearYouView> createState() => _StationNearYouViewState();
}

class _StationNearYouViewState extends State<StationNearYouView> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<Map<String, dynamic>> _fuelStations = [];
  bool _isLoading = true;
  bool _isMapLoaded = false;
  bool _isFetchingStations = false;
  String? _selectedStationId;
  bool _isMapInitialized = false; // Track map initialization

  // Replace with your Google Maps API key (store securely in production)
  static const String _googleApiKey =
      'AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM'; // Replace with actual key

  @override
  void initState() {
    super.initState();
    print('StationNearYouView: initState');
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(position.latitude, position.longitude),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );
      });

      if (!_isFetchingStations) {
        await _fetchFuelStations(position.latitude, position.longitude);
      }

      if (_mapController != null && _isMapLoaded && !_isMapInitialized) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14,
            ),
          ),
        );
        _isMapInitialized = true; // Prevent repeated animations
      }
    } catch (e) {
      print('Error getting location: $e');
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
    }

    setState(() => _isLoading = false);
  }

  Future<void> _fetchFuelStations(double latitude, double longitude) async {
    if (_isFetchingStations) return;
    setState(() => _isFetchingStations = true);

    const String apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    final String url =
        '$apiUrl?location=$latitude,$longitude&radius=5000&type=gas_station&key=$_googleApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      print('API URL: $url');
      print('API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          setState(() {
            _fuelStations = (data['results'] as List).map((station) {
              return {
                'id': station['place_id'],
                'name': station['name'] ?? 'Unknown Station',
                'position': LatLng(
                  station['geometry']['location']['lat'] ?? 0.0,
                  station['geometry']['location']['lng'] ?? 0.0,
                ),
                'address': station['vicinity'] ?? 'No address available',
                'distance': double.parse(_calculateDistance(
                  latitude,
                  longitude,
                  station['geometry']['location']['lat'],
                  station['geometry']['location']['lng'],
                ).replaceAll(' miles', '')),
              };
            }).toList();

            _fuelStations
                .sort((a, b) => a['distance'].compareTo(b['distance']));

            _markers.clear();
            _markers.add(
              Marker(
                markerId: const MarkerId('current_location'),
                position: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                infoWindow: const InfoWindow(title: 'Your Location'),
              ),
            );

            for (var station in _fuelStations) {
              _markers.add(
                Marker(
                  markerId: MarkerId(station['id']),
                  position: station['position'],
                  infoWindow: InfoWindow(
                    title: station['name'],
                    snippet: station['address'],
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  onTap: () {
                    _selectStation(station['id']);
                  },
                ),
              );
            }
          });
        } else {
          throw Exception('API Error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to load fuel stations: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching fuel stations: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching fuel stations: $e')),
      );
    } finally {
      setState(() => _isFetchingStations = false);
    }
  }

  Future<void> _fetchRoute(
      LatLng origin, LatLng destination, String stationId) async {
    const String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json';
    final String url =
        '$apiUrl?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$_googleApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final polylinePoints =
              data['routes'][0]['overview_polyline']['points'];
          final points = _decodePolyline(polylinePoints);
          setState(() {
            _polylines.clear();
            _polylines.add(
              Polyline(
                polylineId: PolylineId(stationId),
                points: points,
                color: Colors.blue,
                width: 5,
              ),
            );
          });

          final bounds = _getBounds([
            origin,
            ...points,
            destination,
          ]);
          if (_mapController != null) {
            _mapController!
                .animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
          }
        } else {
          throw Exception('Directions API Error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to load route: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching route: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching route: $e')),
      );
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  LatLngBounds _getBounds(List<LatLng> points) {
    double south = points[0].latitude;
    double north = points[0].latitude;
    double west = points[0].longitude;
    double east = points[0].longitude;

    for (var point in points) {
      if (point.latitude < south) south = point.latitude;
      if (point.latitude > north) north = point.latitude;
      if (point.longitude < west) west = point.longitude;
      if (point.longitude > east) east = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  void _selectStation(String stationId) {
    setState(() {
      _selectedStationId = stationId;
    });

    final station = _fuelStations.firstWhere((s) => s['id'] == stationId);
    if (_currentPosition != null) {
      _fetchRoute(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        station['position'],
        stationId,
      );
    }
  }

  String _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    double distanceInMeters =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    double distanceInMiles = distanceInMeters / 1609.34;
    return '${distanceInMiles.toStringAsFixed(1)} miles';
  }

  void _onMapCreated(GoogleMapController controller) {
    if (mounted && !_isMapInitialized) {
      setState(() {
        _mapController = controller;
        _isMapLoaded = true;
        _isMapInitialized = true; // Ensure called only once
      });
      print('Map created successfully');
      if (_currentPosition != null) {
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 14,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 2,
          ),
        ),
        title: Text(
          'Station Near You',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.textColor,
            ))
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          // Removed key: UniqueKey() to prevent reinitialization
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _currentPosition != null
                                ? LatLng(_currentPosition!.latitude,
                                    _currentPosition!.longitude)
                                : const LatLng(
                                    23.8103, 90.4125), // Default fallback
                            zoom: 14,
                          ),
                          markers: _markers,
                          polylines: _polylines,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: true,
                        ),
                        if (!_isMapLoaded)
                          const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.textColor,
                          )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_fuelStations.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nearby Fuel Stations',
                                style: h5.copyWith(fontWeight: FontWeight.bold),
                              ),
                              sh8,
                              SizedBox(
                                height: 180,
                                child: ListView.builder(
                                  itemCount: _fuelStations.length > 5
                                      ? 5
                                      : _fuelStations.length,
                                  itemBuilder: (context, index) {
                                    final station = _fuelStations[index];
                                    return GestureDetector(
                                      onTap: () {
                                        _selectStation(station['id']);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              AppImages.gasStationSmall,
                                              scale: 4,
                                            ),
                                            sw8,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    station['name'],
                                                    style: h5,
                                                  ),
                                                  sh5,
                                                  Text(
                                                    station['address'],
                                                    style: h6,
                                                  ),
                                                  sh5,
                                                  Text(
                                                    '${station['distance']} miles',
                                                    style: h6,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            'No fuel stations found nearby.',
                            style: h6,
                          ),
                        sh12,
                        CustomButton(
                          text: 'On the Way',
                          onPressed: () {
                            if (!_isLoading) {
                              setState(() => _isLoading = true);
                              Get.off(() => DriverLiveTrackView(
                                        deliveryId: widget.deliveryId,
                                        orderId: widget.orderId,
                                        userId: widget.userId,
                                        lat: widget.lat,
                                        long: widget.long,
                                      ))
                                  ?.then((_) =>
                                      setState(() => _isLoading = false));
                            }
                          },
                          gradientColors: AppColors.gradientColorGreen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    print('StationNearYouView: dispose');
    _mapController?.dispose();
    super.dispose();
  }
}
