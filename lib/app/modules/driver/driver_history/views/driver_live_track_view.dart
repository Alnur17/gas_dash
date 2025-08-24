import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_completion_checklist_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/socket_service.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_circular_container.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DriverLiveTrackView extends StatefulWidget {
  final String deliveryId;
  final String orderId;
  final String userId;
  final String lat;
  final String long;

  const DriverLiveTrackView({
    super.key,
    required this.deliveryId,
    required this.orderId,
    required this.userId,
    required this.lat,
    required this.long,
  });

  @override
  State<DriverLiveTrackView> createState() => _DriverLiveTrackViewState();
}

class _DriverLiveTrackViewState extends State<DriverLiveTrackView> {
  GoogleMapController? _mapController;
  bool _mapCreated = false;
  bool _isLoading = true;
  String? _errorMessage;

  LatLng? _driverLocation;
  LatLng? _userLocation;
  String _customerAddress = 'Waiting for customer address...';

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final String _googleApiKey = 'AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM';

  SocketService? _socketService;
  String _estimatedTime = 'Calculating...';

  @override
  void initState() {
    super.initState();
    print(">>>>>>>${widget.lat}");
    print(">>>>>>>${widget.long}");
    // Set customer location from constructor
    try {
      final lat = double.parse(widget.lat);
      final long = double.parse(widget.long);
      // Validate coordinates
      if (lat < -90 || lat > 90 || long < -180 || long > 180) {
        throw Exception('Invalid latitude or longitude values');
      }
      _userLocation = LatLng(lat, long);
      _fetchAddressFromLatLng(_userLocation!);
      _updateUserMarker();
    } catch (e) {
      print('Error parsing customer location: $e');
      setState(() {
        _errorMessage = 'Invalid customer location data: $e';
        _isLoading = false;
      });
    }
    _initSocketService();
    _getDriverLocation();
    // Timeout to prevent infinite loading
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && !_mapCreated) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load map. Please check your network or Google Maps configuration.';
        });
      }
    });
  }

  @override
  void dispose() {
    _socketService?.disconnect();
    _mapController?.dispose();
    super.dispose();
  }

  Future<BitmapDescriptor> createCircularDotMarker({
    required Color color,
    double radius = 10.0,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final paint = ui.Paint()
      ..color = color
      ..style = ui.PaintingStyle.fill;

    canvas.drawCircle(Offset(radius, radius), radius, paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage((radius * 2).toInt(), (radius * 2).toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<void> _fetchAddressFromLatLng(LatLng latLng) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$_googleApiKey';

    try {
      print('Fetching address from API: $url');
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          if (mounted) {
            // Prioritize human-readable address
            String address = 'Address not available';
            for (var result in data['results']) {
              if (result['types'].contains('street_address') ||
                  result['types'].contains('premise') ||
                  result['types'].contains('route')) {
                address = result['formatted_address'];
                break;
              }
            }
            // Fallback to first result if no specific types found, but avoid Plus Codes
            if (address == 'Address not available' && !data['results'][0]['formatted_address'].contains('+')) {
              address = data['results'][0]['formatted_address'];
            }
            setState(() {
              _customerAddress = address;
            });
            print('Customer address fetched: $_customerAddress');
          }
        } else {
          print('Geocoding API error: ${data['status']} - ${data['error_message'] ?? 'No error message'}');
          if (mounted) {
            setState(() {
              _customerAddress = 'Unable to fetch address: ${data['status']}';
            });
          }
        }
      } else {
        print('HTTP error fetching address: ${response.statusCode}');
        if (mounted) {
          setState(() {
            _customerAddress = 'Unable to fetch address: HTTP ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      print('Error fetching address: $e');
      if (mounted) {
        setState(() {
          _customerAddress = 'Error fetching address: $e';
        });
      }
    }
  }

  void _initSocketService() async {
    try {
      _socketService = await SocketService().init();
      print('Socket initialized successfully');

      _socketService!.socket.on('orderDeleverd::${widget.orderId}', (data) {
        print('orderDeleverd event received: $data');
        if (mounted) {
          Get.to(() => DriverCompletionChecklistView(widget.deliveryId, widget.orderId));
        }
      });

      if (_driverLocation != null) {
        _emitDriverLocation();
      }
    } catch (e) {
      print('Socket initialization error: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to initialize socket: $e';
        });
      }
    }
  }

  void _emitDriverLocation() {
    if (_driverLocation != null && _socketService != null) {
      _socketService!.socket.emit('driverLocationUpdate', {
        'driverId': widget.deliveryId,
        'latitude': _driverLocation!.latitude,
        'longitude': _driverLocation!.longitude,
      });
      print('Emitted driver location: $_driverLocation');
    }
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _emitDriverLocation();
      }
    });
  }

  Future<void> _updateUserMarker() async {
    if (_userLocation == null) return;

    final userIcon = await createCircularDotMarker(color: Colors.blue, radius: 30.0);
    _markers.removeWhere((m) => m.markerId.value == 'User');
    _markers.add(
      Marker(
        markerId: const MarkerId('User'),
        position: _userLocation!,
        infoWindow: const InfoWindow(title: 'Customer Location'),
        icon: userIcon,
      ),
    );
    // Fetch route after updating user marker
    await _fetchRoute();
  }

  Future<void> _updateDriverMarker() async {
    if (_driverLocation == null) return;

    final driverIcon = await createCircularDotMarker(color: Colors.red, radius: 30.0);
    _markers.removeWhere((m) => m.markerId.value == 'Driver');
    _markers.add(
      Marker(
        markerId: const MarkerId('Driver'),
        position: _driverLocation!,
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: driverIcon,
      ),
    );
    // Fetch route after updating driver marker
    await _fetchRoute();
  }

  void _onMapCreated(GoogleMapController controller) {
    if (mounted) {
      print('Map created with controller: $controller');
      setState(() {
        _mapController = controller;
        _mapCreated = true;
        _isLoading = false;
      });
      if (_driverLocation != null || _userLocation != null) {
        _updateCameraPosition();
      }
    }
  }

  Future<void> _getDriverLocation() async {
    try {
      print('Checking location services...');
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Location services are disabled. Please enable them in your device settings.';
          });
        }
        return;
      }

      print('Checking location permissions...');
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied.');
          if (mounted) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'Location permissions are denied. Please grant location access.';
            });
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied.');
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Location permissions are permanently denied. Please enable them in app settings.';
          });
        }
        return;
      }

      print('Fetching driver location...');
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          _driverLocation = LatLng(position.latitude, position.longitude);
        });
        print('Driver location set: $_driverLocation');
        await _updateDriverMarker();
        _emitDriverLocation();
        if (_userLocation != null) {
          await _fetchRoute();
          await _fetchAddressFromLatLng(_userLocation!);
        }
        if (_mapCreated) {
          _updateCameraPosition();
        }
      }
    } catch (e) {
      print('Error getting driver location: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to get location: $e. Please ensure location services are enabled.';
        });
      }
    }
  }

  Future<void> _fetchRoute() async {
    if (_driverLocation == null || _userLocation == null) {
      print('Cannot fetch route: driverLocation or userLocation is null');
      return;
    }

    // Validate coordinates
    if (_driverLocation!.latitude < -90 || _driverLocation!.latitude > 90 ||
        _driverLocation!.longitude < -180 || _driverLocation!.longitude > 180 ||
        _userLocation!.latitude < -90 || _userLocation!.latitude > 90 ||
        _userLocation!.longitude < -180 || _userLocation!.longitude > 180) {
      print('Invalid coordinates: driver=$_driverLocation, user=$_userLocation');
      if (mounted) {
        setState(() {
          _errorMessage = 'Invalid location coordinates. Please check the provided locations.';
        });
      }
      return;
    }

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_driverLocation!.latitude},${_driverLocation!.longitude}&destination=${_userLocation!.latitude},${_userLocation!.longitude}&key=$_googleApiKey';

    try {
      print('Fetching route from API: $url');
      setState(() {
        _errorMessage = null; // Clear previous error
      });
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          final polylinePoints = PolylinePoints();
          final List<PointLatLng> result = polylinePoints.decodePolyline(
            data['routes'][0]['overview_polyline']['points'],
          );

          final List<LatLng> polylineCoordinates = result
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          final duration = data['routes'][0]['legs'][0]['duration']['text'];

          if (mounted) {
            setState(() {
              _polylines.clear();
              _polylines.add(
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: Colors.blue,
                  width: 5,
                  points: polylineCoordinates,
                ),
              );
              _estimatedTime = duration;
            });
            print('Route fetched, estimated time: $_estimatedTime');
            _updateCameraPosition(); // Update camera to show the route
          }
        } else {
          print('Directions API error: ${data['status']} - ${data['error_message'] ?? 'No error message'}');
          if (mounted) {
            setState(() {
              _errorMessage = data['status'] == 'ZERO define ZERO_RESULTS'
                  ? 'No route found. Please check the locations or network connection.'
                  : 'Failed to fetch route: ${data['status']}';
            });
          }
        }
      } else {
        print('HTTP error fetching route: ${response.statusCode}');
        if (mounted) {
          setState(() {
            _errorMessage = 'Failed to fetch route: HTTP ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      print('Error fetching route: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to fetch route: $e';
        });
      }
    }
  }

  void _updateCameraPosition() {
    if (!_mapCreated || _mapController == null) {
      print('Cannot update camera: map not created or controller is null');
      return;
    }

    print('Updating camera position...');
    if (_driverLocation == null && _userLocation == null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: const LatLng(23.8103, 90.4125),
            zoom: 14,
          ),
        ),
      );
      return;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(
        (_driverLocation?.latitude ?? _userLocation!.latitude) <
            (_userLocation?.latitude ?? _driverLocation?.latitude ?? _userLocation!.latitude)
            ? (_driverLocation?.latitude ?? _userLocation!.latitude)
            : (_userLocation?.latitude ?? _driverLocation?.latitude ?? _userLocation!.latitude),
        (_driverLocation?.longitude ?? _userLocation!.longitude) <
            (_userLocation?.longitude ?? _driverLocation?.longitude ?? _userLocation!.longitude)
            ? (_driverLocation?.longitude ?? _userLocation!.longitude)
            : (_userLocation?.longitude ?? _driverLocation?.longitude ?? _userLocation!.longitude),
      ),
      northeast: LatLng(
        (_driverLocation?.latitude ?? _userLocation!.latitude) >
            (_userLocation?.latitude ?? _driverLocation?.latitude ?? _userLocation!.latitude)
            ? (_driverLocation?.latitude ?? _userLocation!.latitude)
            : (_userLocation?.latitude ?? _driverLocation?.latitude ?? _userLocation!.latitude),
        (_driverLocation?.longitude ?? _userLocation!.longitude) >
            (_userLocation?.longitude ?? _driverLocation?.longitude ?? _userLocation!.longitude)
            ? (_driverLocation?.longitude ?? _userLocation!.longitude)
            : (_userLocation?.longitude ?? _driverLocation?.longitude ?? _userLocation!.longitude),
      ),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Building widget: _isLoading=$_isLoading, _errorMessage=$_errorMessage, _mapCreated=$_mapCreated');
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
          'Live Track',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            key: const ValueKey('driver_live_tracking_map'),
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(23.8103, 90.4125),
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: _driverLocation != null,
            myLocationButtonEnabled: _driverLocation != null,
            zoomControlsEnabled: false,
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: AppColors.textColor,))
          else if (_errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    if (_errorMessage!.contains('No route found'))
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: CustomButton(
                          text: 'Retry Route',
                          onPressed: () async {
                            setState(() {
                              _errorMessage = null;
                              _isLoading = true;
                            });
                            await _fetchRoute();
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          gradientColors: AppColors.gradientColorGreen,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: AppColors.white,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppImages.estimatedTime,
                          scale: 4,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estimated Time',
                              style: h5.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _estimatedTime,
                              style: h6.copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ],
                    ),
                    sh12,
                    Row(
                      children: [
                        Image.asset(
                          AppImages.locationRed,
                          scale: 4,
                        ),
                        sw8,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer Location',
                                style: h5,
                              ),
                              sh5,
                              Text(
                                _customerAddress,
                                style: h6,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sh12,
                    CustomButton(
                      text: 'Mark As Arrived',
                      onPressed: () {
                        Get.to(() => DriverCompletionChecklistView(widget.deliveryId, widget.orderId));
                      },
                      gradientColors: AppColors.gradientColorGreen,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}