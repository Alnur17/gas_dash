import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../common/app_images/app_images.dart';
import '../controllers/order_fuel_controller.dart';

class MapPickerView extends StatefulWidget {
  const MapPickerView({super.key});

  @override
  State<MapPickerView> createState() => _MapPickerViewState();
}

class _MapPickerViewState extends State<MapPickerView> {
  final OrderFuelController controller = Get.find<OrderFuelController>();
  GoogleMapController? _mapController;
  LatLng _selectedPosition = const LatLng(0, 0);
  String _selectedAddress = 'Select a location';

  @override
  void initState() {
    super.initState();
    // Initialize with current location if available
    if (controller.latitude.value != null && controller.longitude.value != null) {
      _selectedPosition = LatLng(
        controller.latitude.value!,
        controller.longitude.value!,
      );
      _selectedAddress = controller.currentLocation.value;
    }
  }

  Future<void> _updateAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _selectedAddress =
          '${place.street}, ${place.subLocality}, ${place.locality}';
        });
      } else {
        setState(() {
          _selectedAddress = 'Address not found';
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = 'Failed to get address';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Select Location', style: titleStyle),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedPosition.latitude != 0 && _selectedPosition.longitude != 0
                  ? _selectedPosition
                  : const LatLng(37.7749, -122.4194), // Default to San Francisco
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            onTap: (LatLng position) {
              setState(() {
                _selectedPosition = position;
              });
              _updateAddress(position);
            },
            markers: {
              Marker(
                markerId: const MarkerId('selected-location'),
                position: _selectedPosition,
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: AppColors.white,
              child: Text(
                _selectedAddress,
                style: h6,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomButton(
              text: 'Confirm Location',
              onPressed: () {
                controller.updateLocation(
                  _selectedPosition.latitude,
                  _selectedPosition.longitude,
                  _selectedAddress,
                );
                Get.back();
              },
              gradientColors: AppColors.gradientColorGreen,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}