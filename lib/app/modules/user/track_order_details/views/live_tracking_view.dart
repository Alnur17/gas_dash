import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/about_driver_information/views/about_driver_information_view.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class LiveTrackingView extends StatefulWidget {
  const LiveTrackingView({super.key});

  @override
  State<LiveTrackingView> createState() => _LiveTrackingViewState();
}

class _LiveTrackingViewState extends State<LiveTrackingView> {
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
                          '25 Minutes',
                          style: h6,
                        ),
                      ],
                    ),
                  ],
                ),

                sh12,
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: (){
                    Get.to(()=> AboutDriverInformationView(driverId: '683be4879bcebfdcbde1e5aa'));
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(AppImages.profileImageTwo),
                  ),
                  title: Text('John Deo',style: h3.copyWith(fontSize: 18),),
                  subtitle: Row(
                    children: [
                      Image.asset(AppImages.star,scale: 4,),
                      sw5,
                      Text('4.5(1.2k)',style: h3.copyWith(fontSize: 14),)
                    ],
                  ),
                  trailing: Image.asset(AppImages.call,scale: 4,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
