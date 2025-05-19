import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_live_track_view.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import 'driver_completion_checklist_view.dart';

class StationNearYouView extends StatefulWidget {
  const StationNearYouView({super.key});

  @override
  State<StationNearYouView> createState() => _StationNearYouViewState();
}

class _StationNearYouViewState extends State<StationNearYouView> {
  late GoogleMapController _mapController;

  final LatLng _initialPosition = LatLng(23.8103, 90.4125);

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
          'Station Near You',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppImages.gasStationSmall,
                      scale: 4,
                    ),
                    sw8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chevron',
                          style: h5,
                        ),
                        sh5,
                        Text(
                          '456 Pine St, Los Angeles, CA',
                          style: h6,
                        ),
                        sh5,
                        Text(
                          '3 miles, 7 mins',
                          style: h6,
                        ),
                      ],
                    ),
                    Text(
                      'Regular: \$3.69/gal',
                      style: h6.copyWith(color: AppColors.darkRed),
                    ),
                  ],
                ),
                sh12,
                CustomButton(
                  text: 'On the Way',
                  onPressed: () {
                    Get.to(() => DriverLiveTrackView());
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
