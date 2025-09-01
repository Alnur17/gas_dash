import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/about_driver_information/views/about_driver_information_view.dart';
import 'package:gas_dash/app/modules/user/track_order_details/controllers/trips_controller.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_loader.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/socket_service.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import 'dart:convert';
import '../../about_driver_information/views/write_review_view.dart';
import '../../order_history/controllers/order_history_controller.dart';
import 'dart:ui' as ui;

class LiveTrackingView extends StatefulWidget {
  final int index;
  const LiveTrackingView({super.key, required this.index});

  @override
  State<LiveTrackingView> createState() => _LiveTrackingViewState();
}

class _LiveTrackingViewState extends State<LiveTrackingView> {
  final TextEditingController tipsAmount = TextEditingController();
  final TripsController tripsController = Get.put(TripsController());

  GoogleMapController? _mapController;
  bool _mapCreated = false;
  bool _isLoading = true;
  String? _errorMessage;

  LatLng? _userLocation;
  LatLng? _driverLocation; // Removed default value

  final OrderHistoryController orderHistoryController =
  Get.put(OrderHistoryController());

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final String _googleApiKey = 'AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM';

  SocketService? _socketService;
  String? _driverId;
  String? _orderId;
  String? _driverName;

  String? _estimatedTime; // Changed to nullable, no default value

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderHistoryController.fetchOrderHistory();
    });
    _initSocketService();
    _getUserLocation();
    if (orderHistoryController.inProcessOrders.isNotEmpty &&
        orderHistoryController.inProcessOrders[0].driverId != null) {
      _driverId =
          orderHistoryController.inProcessOrders[0].driverId!.id.toString();
      _orderId = orderHistoryController.inProcessOrders[0].id.toString();
      _driverName =
          orderHistoryController.inProcessOrders[0].driverId!.fullname ??
              'Driver';
    }
    print("$_driverId ddd" +
        "${orderHistoryController.inProcessOrders[0].driverId!.id}" +
        "eeeeeeeeeee");
    print("$_orderId" + "order ID>>>>>>>>>>>>>>");
    // Timeout to prevent infinite loading
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && _isLoading) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load map. Please try again.';
        });
      }
    });
  }

  // @override
  // void dispose() {
  //   _socketService?.disconnect();
  //   _mapController?.dispose();
  //   super.dispose();
  //}

  Future<BitmapDescriptor> createCircularDotMarker(
      {required Color color, double radius = 10.0}) async {
    // Unchanged
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final paint = ui.Paint()
      ..color = color
      ..style = ui.PaintingStyle.fill;

    canvas.drawCircle(Offset(radius, radius), radius, paint);

    final picture = recorder.endRecording();
    final img =
    await picture.toImage((radius * 2).toInt(), (radius * 2).toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  void _initSocketService() async {
    try {
      _socketService = await SocketService().init();
      print('Socket initialized successfully');
      if (_driverId != null) {
        _socketService!.socket.on('orderDelivery::$_orderId', (data) {
          print('orderDeleverd event received: $data');
          Get.dialog(
            Dialog(
              child: Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 50,
                        color: AppColors.green,
                      ),
                      sh10,
                      Text(
                        "Your delivery is complete! How was your experience? A quick review can make their day!",
                        style: h4,
                        textAlign: TextAlign.center,
                      ),
                      sh10,
                      CustomButton(
                        backgroundColor: AppColors.green,
                        text: "Give Rating",
                        gradientColors: AppColors.gradientColorGreen,
                        onPressed: () {
                          Get.to(() => WriteReviewView(_driverId));
                        },
                      ),
                      sh10,
                      CustomButton(
                        backgroundColor: AppColors.green,
                        text: "Give Tips",
                        gradientColors: AppColors.gradientColorGreen,
                        onPressed: () {
                          Get.dialog(
                            Dialog(
                              child: Container(
                                height: 250,
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextField(
                                        height: 48,
                                        hintText: 'Enter you tips',
                                        controller: tipsAmount,
                                      ),
                                      sh10,
                                      Obx(
                                            () => tripsController.isLoading.value
                                            ? CustomLoader(
                                            color: AppColors.white)
                                            : CustomButton(
                                          backgroundColor:
                                          AppColors.green,
                                          text: "Send",
                                          gradientColors:
                                          AppColors.gradientColorGreen,
                                          onPressed: () {
                                            tripsController.createTrips(
                                              driverId: _driverId
                                                  .toString(),
                                              amount:
                                              tipsAmount.text.trim(),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });

        _socketService!.socket.on('locationUpdate', (data) {
          print('Socket event received: $data');
          if (data is Map<String, dynamic> &&
              data.containsKey('latitude') &&
              data.containsKey('longitude')) {
            if (mounted) {
              setState(() {
                _driverLocation = LatLng(data['latitude'], data['longitude']);
                _updateDriverMarker();
              });
              _fetchRoute();
              if (_mapCreated) {
                _updateCameraPosition();
              }
            }
          }
        });
      }
    } catch (e) {
      print('Socket initialization error: $e');
    }
  }

  Future<void> _updateDriverMarker() async {
    if (_driverLocation == null) return; // Add check for null
    final driverIcon =
    await createCircularDotMarker(color: Colors.red, radius: 30.0);
    _markers.removeWhere((m) => m.markerId.value == 'Driver');
    _markers.add(
      Marker(
        markerId: const MarkerId('Driver'),
        position: _driverLocation!,
        infoWindow: const InfoWindow(title: 'Driver Location'),
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
      if (_userLocation != null && _driverLocation != null) {
        _updateCameraPosition();
      }
    }
  }

  Future<void> _getUserLocation() async {
    try {
      print('Checking location services...');
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage =
            'Location services are disabled. Please enable them.';
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

      print('Fetching user location...');
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (mounted) {
        final userIcon =
        await createCircularDotMarker(color: Colors.blue, radius: 30.0);
        setState(() {
          _userLocation = LatLng(position.latitude, position.longitude);
          _markers.add(
              Marker(
                markerId: const MarkerId('Me'),
                position: _userLocation!,
                infoWindow: const InfoWindow(title: 'Your Location'),
                icon: userIcon,
                ),
              );
              _isLoading = false;
          });
        print('User location set: $_userLocation');

        if (_driverLocation != null) {
          await _updateDriverMarker();
          await _fetchRoute();
          if (_mapCreated) {
            _updateCameraPosition();
          }
        }
      }
    } catch (e) {
      print('Error getting user location: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to get location: $e';
        });
      }
    }
  }

  Future<void> _fetchRoute() async {
    if (_userLocation == null || _driverLocation == null) {
      print('Cannot fetch route: user or driver location missing');
      return;
    }

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_userLocation!.latitude},${_userLocation!.longitude}&destination=${_driverLocation!.latitude},${_driverLocation!.longitude}&key=$_googleApiKey';

    try {
      print('Fetching route from API...');
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          final polylinePoints = PolylinePoints();
          final List<PointLatLng> result = polylinePoints
              .decodePolyline(data['routes'][0]['overview_polyline']['points']);

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
              _estimatedTime = duration; // Set dynamically from API
            });
            print('Route fetched, estimated time: $_estimatedTime');
          }
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

  void _updateCameraPosition() {
    if (_userLocation == null ||
        _driverLocation == null ||
        !_mapCreated ||
        _mapController == null) {
      print('Cannot update camera: missing location or map not created');
      return;
    }

    print('Updating camera position...');
    final bounds = LatLngBounds(
      southwest: LatLng(
        _userLocation!.latitude < _driverLocation!.latitude
            ? _userLocation!.latitude
            : _driverLocation!.latitude,
        _userLocation!.longitude < _driverLocation!.longitude
            ? _userLocation!.longitude
            : _driverLocation!.longitude,
      ),
      northeast: LatLng(
        _userLocation!.latitude > _driverLocation!.latitude
            ? _driverLocation!.latitude
            : _driverLocation!.latitude,
        _userLocation!.longitude > _driverLocation!.longitude
            ? _userLocation!.longitude
            : _driverLocation!.longitude,
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
          else if (_userLocation == null)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Waiting for your location...',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else if (_driverLocation == null)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'The delivery boy is not available now.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                GoogleMap(
                  key: const ValueKey('live_tracking_map'),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _userLocation ?? const LatLng(0, 0),
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
                              _driverLocation == null
                                  ? 'The delivery boy is not available now.'
                                  : _estimatedTime ?? 'Calculating...',
                              style: h6.copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Get.to(() => AboutDriverInformationView(
                          driver: orderHistoryController
                              .inProcessOrders[widget.index].driverId!,
                          userId: orderHistoryController
                              .inProcessOrders[widget.index].userId!,
                        ));
                      },
                      leading: const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(AppImages.profileImageTwo),
                      ),
                      title: Text(
                        _driverName ?? 'Unknown Driver',
                        style: h3.copyWith(fontSize: 18),
                      ),
                      subtitle: Row(
                        children: [
                          Image.asset(AppImages.star, scale: 4),
                          const SizedBox(width: 5),
                          Text(
                            '${orderHistoryController.inProcessOrders[widget.index].driverId!.avgRating}(${orderHistoryController.inProcessOrders[0].driverId?.reviews.length ?? 0})',
                            style: h3.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () async {
                          final Uri phoneUri = Uri(
                              scheme: 'tel',
                              path:
                              '${orderHistoryController.inProcessOrders[widget.index].driverId!.phoneNumber ?? 0}');
                          if (await canLaunchUrl(phoneUri)) {
                            await launchUrl(phoneUri);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Could not launch phone dialer')),
                            );
                          }
                        },
                        child: Image.asset(AppImages.call, scale: 4),
                      ),
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
