import 'dart:convert';
import 'dart:typed_data';
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

  const DriverLiveTrackView({
    super.key,
    required this.deliveryId,
    required this.orderId,
    required this.userId,
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

  final String _googleApiKey = 'AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM'; // Replace with your actual API key

  SocketService? _socketService;
  String _estimatedTime = 'Calculating...';

  @override
  void initState() {
    super.initState();
    _initSocketService();
    _getDriverLocation();
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && _isLoading) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load map. Check API key, network, or billing.';
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
            setState(() {
              _customerAddress = data['results'][0]['formatted_address'] ?? 'Unknown Address';
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
          _customerAddress = 'Error fetching address';
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

      _socketService!.socket.on('serverToSendLocation::${widget.userId}', (data) {
        print('User location event received: $data');
        if (data is Map<String, dynamic> &&
            data.containsKey('latitude') &&
            data.containsKey('longitude')) {
          if (mounted) {
            final newLatLng = LatLng(data['latitude'], data['longitude']);
            setState(() {
              _userLocation = newLatLng;
            });
            _updateUserMarker();
            _fetchAddressFromLatLng(newLatLng);
            _fetchRoute();
            if (_mapCreated) {
              _updateCameraPosition();
            }
          }
        } else {
          print('Invalid user location data: $data');
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
  }

  void _onMapCreated(GoogleMapController controller) {
    if (mounted) {
      print('Map created successfully');
      setState(() {
        _mapController = controller;
        _mapCreated = true;
        _isLoading = false;
      });
      if (_driverLocation != null) {
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
            _errorMessage = 'Location services are disabled. Please enable them.';
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
              _errorMessage = 'Location permissions are denied.';
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
            _errorMessage = 'Location permissions are permanently denied.';
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
        await _updateDriverMarker();
        print('Driver location set: $_driverLocation');
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
          _errorMessage = 'Failed to get location: $e';
        });
      }
    }
  }

  Future<void> _fetchRoute() async {
    if (_driverLocation == null || _userLocation == null) return;

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_driverLocation!.latitude},${_driverLocation!.longitude}&destination=${_userLocation!.latitude},${_userLocation!.longitude}&key=$_googleApiKey';

    try {
      print('Fetching route from API: $url');
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
          }
        } else {
          print('Directions API error: ${data['status']} - ${data['error_message'] ?? 'No error message'}');
          if (mounted) {
            setState(() {
              _errorMessage = 'Failed to fetch route: ${data['status']}';
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
    if (_driverLocation == null || !_mapCreated || _mapController == null) return;

    print('Updating camera position...');
    final bounds = LatLngBounds(
      southwest: LatLng(
        _driverLocation!.latitude < (_userLocation?.latitude ?? _driverLocation!.latitude)
            ? _driverLocation!.latitude
            : (_userLocation?.latitude ?? _driverLocation!.latitude),
        _driverLocation!.longitude < (_userLocation?.longitude ?? _driverLocation!.longitude)
            ? _driverLocation!.longitude
            : (_userLocation?.longitude ?? _driverLocation!.longitude),
      ),
      northeast: LatLng(
        _driverLocation!.latitude > (_userLocation?.latitude ?? _driverLocation!.latitude)
            ? _driverLocation!.latitude
            : (_userLocation?.latitude ?? _driverLocation!.latitude),
        _driverLocation!.longitude > (_userLocation?.longitude ?? _driverLocation!.longitude)
            ? _driverLocation!.longitude
            : (_userLocation?.longitude ?? _driverLocation!.longitude),
      ),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
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
          'Live Track',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            GoogleMap(
              key: const ValueKey('driver_live_tracking_map'),
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _driverLocation ?? const LatLng(23.8103, 90.4125),
                zoom: 14,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
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