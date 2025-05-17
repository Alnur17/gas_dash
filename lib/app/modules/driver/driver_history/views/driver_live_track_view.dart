import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_completion_checklist_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/widgets/custom_circular_container.dart';

class DriverLiveTrackView extends StatefulWidget {
  const DriverLiveTrackView({super.key});

  @override
  State<DriverLiveTrackView> createState() => _DriverLiveTrackViewState();
}

class _DriverLiveTrackViewState extends State<DriverLiveTrackView> {
  late GoogleMapController _mapController;

  final LatLng _initialPosition = LatLng(23.8103, 90.4125); // Dhaka coords

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId('dhaka_marker'),
        position: _initialPosition,
        infoWindow: InfoWindow(title: 'Dhaka'),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
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
        ), // Tailwind yellow shade kinda
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12,
              ),
              markers: _markers,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppImages.locationRed,
                      scale: 4,
                    ),
                    sw8,
                    Text(
                      'Location',
                      style: h5,
                    ),
                  ],
                ),
                sh5,
                Text(
                  '1901 Thornridge Cir. Shiloh',
                  style: h6,
                ),
                sh12,
                CustomButton(
                  text: 'Mark As Arrived',
                  onPressed: () {
                    Get.to(()=> DriverCompletionChecklistView());
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
}
