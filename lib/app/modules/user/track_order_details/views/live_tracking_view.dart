import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/about_driver_information/views/about_driver_information_view.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/socket_service.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../about_driver_information/controllers/about_driver_information_controller.dart';

import 'dart:convert';

class LiveTrackingView extends StatefulWidget {
  const LiveTrackingView({super.key});

  @override
  State<LiveTrackingView> createState() => _LiveTrackingViewState();
}

class _LiveTrackingViewState extends State<LiveTrackingView> {
  late GoogleMapController _mapController;

  // User's location (fetched dynamically)
  LatLng? _userLocation;
  // Driver's location (updated via socket)
  LatLng _driverLocation = const LatLng(23.8203, 90.4225); // Initial driver coords

  final AboutDriverInformationController controller =
  Get.put(AboutDriverInformationController());

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  // Google Maps Directions API key
  final String _googleApiKey = 'AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM';

  // Socket service
  late SocketService _socketService;
  String? _driverId; // Set this based on your driver ID

  // Estimated time
  String _estimatedTime = '25 Minutes';

  @override
  void initState() {
    super.initState();
    // Initialize socket service
    _initSocketService();
    // Fetch user's location
    _getUserLocation();
    // Set driver ID (example; adjust based on your data)
    _driverId = controller.reviews[0].driverId?.id.toString();
  }

  @override
  void dispose() {
    _socketService.disconnect(); // Disconnect socket
    _mapController.dispose();
    super.dispose();
  }

  // Initialize socket service and listen for driver location updates
  void _initSocketService() async {
    _socketService = await SocketService().init();
    if (_driverId != null) {
      _socketService.socket.on('serverToSendLocation::$_driverId', (data) {
        if (data is Map<String, dynamic> &&
            data.containsKey('latitude') &&
            data.containsKey('longitude')) {
          setState(() {
            _driverLocation = LatLng(data['latitude'], data['longitude']);
            // Update driver marker
            _markers.removeWhere((m) => m.markerId.value == 'Driver');
            _markers.add(
              Marker(
                markerId: const MarkerId('Driver'),
                position: _driverLocation,
                infoWindow: const InfoWindow(title: 'Driver Location'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              ),
            );
          });
          // Redraw route
          _fetchRoute();
          _updateCameraPosition();
        }
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_userLocation != null) {
      _updateCameraPosition();
    }
  }

  // Get user's current location
  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('Me'),
          position: _userLocation!,
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });

    // Fetch initial route
    await _fetchRoute();
    _updateCameraPosition();
  }

  // Fetch route from Google Directions API
  Future<void> _fetchRoute() async {
    if (_userLocation == null) return;

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_userLocation!.latitude},${_userLocation!.longitude}&destination=${_driverLocation.latitude},${_driverLocation.longitude}&key=$_googleApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          final polylinePoints = PolylinePoints();
          final List<PointLatLng> result = polylinePoints.decodePolyline(
              data['routes'][0]['overview_polyline']['points']);

          // Convert to list of LatLng for Google Maps
          final List<LatLng> polylineCoordinates = result
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          // Extract estimated time
          final duration = data['routes'][0]['legs'][0]['duration']['text'];

          setState(() {
            _polylines.clear(); // Clear previous polylines
            _polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                color: Colors.blue,
                width: 5,
                points: polylineCoordinates,
              ),
            );
            _estimatedTime = duration; // Update estimated time
          });
        } else {
          print('Directions API error: ${data['status']}');
        }
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching route: $e');
    }
  }

  // Adjust camera to show both user and driver locations
  void _updateCameraPosition() {
    if (_userLocation == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        _userLocation!.latitude < _driverLocation.latitude
            ? _userLocation!.latitude
            : _driverLocation.latitude,
        _userLocation!.longitude < _driverLocation.longitude
            ? _userLocation!.longitude
            : _driverLocation.longitude,
      ),
      northeast: LatLng(
        _userLocation!.latitude > _driverLocation.latitude
            ? _userLocation!.latitude
            : _driverLocation.latitude,
        _userLocation!.longitude > _driverLocation.longitude
            ? _userLocation!.longitude
            : _driverLocation.longitude,
      ),
    );

    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50), // 50 is padding
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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _userLocation ?? const LatLng(23.8103, 90.4125),
                zoom: 14,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppImages.estimatedTime,
                      scale: 4,
                    ),
                    sw8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimated Time',
                          style: h5,
                        ),
                        sh5,
                        Text(
                          _estimatedTime,
                          style: h6,
                        ),
                      ],
                    ),
                  ],
                ),
                sh12,
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Get.to(() => AboutDriverInformationView(
                        driverId: _driverId ?? ''));
                  },
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(AppImages.profileImageTwo),
                  ),
                  title: Text('', style: h3.copyWith(fontSize: 18)),
                  subtitle: Row(
                    children: [
                      Image.asset(AppImages.star, scale: 4),
                      sw5,
                      Text('4.5(1.2k)', style: h3.copyWith(fontSize: 14)),
                    ],
                  ),
                  trailing: Image.asset(AppImages.call, scale: 4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}