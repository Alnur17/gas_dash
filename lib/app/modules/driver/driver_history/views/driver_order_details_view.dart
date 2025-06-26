import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:get/get.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:intl/intl.dart';

import '../../driver_home/controllers/driver_home_controller.dart';
import '../../driver_home/model/single_order_by_Id_model.dart';

class DriverOrderDetailsView extends StatefulWidget {
  final SingleOrderData? orderData;
  final String? location;

  const DriverOrderDetailsView( {super.key, this.orderData,this.location,});

  @override
  State<DriverOrderDetailsView> createState() => _DriverOrderDetailsViewState();
}

class _DriverOrderDetailsViewState extends State<DriverOrderDetailsView> {
  final DriverHomeController homeController = Get.put(DriverHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text('Order Details', style: titleStyle),
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.back,
              scale: 4,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Common Customer Section
              Text(
                'Customer',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh8,
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      widget.orderData?.userId?.image ?? AppImages.profileImageTwo,
                    ),
                  ),
                  sw8,
                  Text(
                    widget.orderData?.userId?.fullname ?? 'Unknown',
                    style: h6,
                  ),
                ],
              ),
              sh12,
              // Common Order ID Section
              Text(
                'Order ID',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                widget.orderData?.id ?? 'N/A',
                style: h6,
              ),
              sh12,
              // Common Delivery Date & Time Section
              Text(
                'Delivery Date & time',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                widget.orderData?.createdAt != null
                    ? DateFormat('dd MMM, yyyy').format(widget.orderData!.createdAt!)
                    : 'N/A',
                style: h6,
              ),
              sh12,
              // Common Location Section
              Text(
                'Location',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Row(
                children: [
                  Image.asset(
                    AppImages.locationRed,
                    scale: 4,
                  ),
                  sw8,
                  Text(
                   widget.location ?? 'Unknown Location',
                    style: h6,
                  ),
                ],
              ),
              sh12,
              // Common Vehicle Section
              Text(
                'Vehicle',
                style: h5.copyWith(fontWeight: FontWeight.w600),
              ),
              sh5,
              Text(
                widget.orderData?.vehicleId != null
                    ? '${widget.orderData!.vehicleId!.make ?? 'Unknown'} ${widget.orderData!.vehicleId!.model ?? 'Unknown'} (${widget.orderData!.vehicleId!.year?.toInt() ?? 'N/A'})'
                    : 'Unknown Vehicle',
                style: h6,
              ),
              sh12,
              // Conditional Section based on orderStatus
              if (widget.orderData?.orderStatus?.toLowerCase() == 'fuel')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fuel Type',
                      style: h5.copyWith(fontWeight: FontWeight.w600),
                    ),
                    sh5,
                    Text(
                      widget.orderData?.orderType ?? 'Unknown',
                      style: h6,
                    ),
                    sh12,
                    Text(
                      'Amount',
                      style: h5.copyWith(fontWeight: FontWeight.w600),
                    ),
                    sh5,
                    Text(
                      widget.orderData?.price != null
                          ? '${widget.orderData?.price!.toStringAsFixed(2)} gallons'
                          : 'N/A',
                      style: h6,
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service',
                      style: h5.copyWith(fontWeight: FontWeight.w600),
                    ),
                    sh5,
                    Text(
                      widget.orderData?.orderType ?? 'Unknown Service',
                      style: h6,
                    ),
                  ],
                ),
              sh20,
              // Common Start Delivery Button
              // CustomButton(
              //   text: 'Start Delivery',
              //   onPressed: () {
              //     homeController.viewOrderDetails(widget.orderData?.id ?? '', widget.orderData?.location ?? 'Unknown');
              //   },
              //   gradientColors: AppColors.gradientColor,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}