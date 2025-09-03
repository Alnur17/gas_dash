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
  const StationNearYouView({
    super.key,
    required this.deliveryId,
    required this.orderId,
    required this.userId,
  });

  @override
  State<StationNearYouView> createState() => _StationNearYouViewState();
}

class _StationNearYouViewState extends State<StationNearYouView> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  List<Map<String, dynamic>> _fuelStations = [];
  bool _isLoading = true;
  bool _isMapLoaded = false;

  // Replace with your Google Maps API key
  static const String _googleApiKey = 'AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM'; // Replace with actual key

  @override
  void initState() {
    super.initState();
    print('StationNearYouView: initState');
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    // Check location permission
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
        const SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    // Get current position
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
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );
      });

      // Fetch nearby fuel stations
      await _fetchFuelStations(position.latitude, position.longitude);

      // Animate camera if map is ready
      if (_mapController != null && _isMapLoaded) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14,
            ),
          ),
        );
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
    const String apiUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
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
                'price': station['price_level'] != null
                    ? '\$${station['price_level']}/gal'
                    : 'Price not available',
                'distance': double.parse(_calculateDistance(
                  latitude,
                  longitude,
                  station['geometry']['location']['lat'],
                  station['geometry']['location']['lng'],
                ).replaceAll(' miles', '')),
              };
            }).toList();

            // Sort by distance
            _fuelStations.sort((a, b) => a['distance'].compareTo(b['distance']));

            // Add fuel station markers
            for (var station in _fuelStations) {
              _markers.add(
                Marker(
                  markerId: MarkerId(station['id']),
                  position: station['position'],
                  infoWindow: InfoWindow(
                    title: station['name'],
                    snippet: '${station['address']} - ${station['price']}',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
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
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching fuel stations: $e')),
      );
    }
  }

  String _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    double distanceInMiles = distanceInMeters / 1609.34;
    return '${distanceInMiles.toStringAsFixed(1)} miles';
  }

  void _onMapCreated(GoogleMapController controller) {
    if (mounted) {
      setState(() {
        _mapController = controller;
        _isMapLoaded = true;
      });
      print('Map created successfully');
      if (_currentPosition != null) {
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
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
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  key: UniqueKey(),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition != null
                        ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                        : const LatLng(23.8103, 90.4125),
                    zoom: 14,
                  ),
                  markers: _markers,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                ),
                if (!_isMapLoaded)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                        height: 150, // Adjust height as needed
                        child: ListView.builder(
                          itemCount: _fuelStations.length > 5 ? 5 : _fuelStations.length,
                          itemBuilder: (context, index) {
                            final station = _fuelStations[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    AppImages.gasStationSmall,
                                    scale: 4,
                                  ),
                                  sw8,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Text(
                                    station['price'],
                                    style: h6.copyWith(color: AppColors.darkRed),
                                  ),
                                ],
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
                      ))?.then((_) => setState(() => _isLoading = false));
                    }
                  },
                  gradientColors: AppColors.gradientColorGreen,
                ),
              ],
            ),
          ),
        ],
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