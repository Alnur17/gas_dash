import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/order_fuel/controllers/order_fuel_controller.dart';
import 'package:gas_dash/app/modules/user/payment/views/payment_success_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/helper/socket_service.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';

class AssigningToDriverView extends StatefulWidget {
  final String orderId;
  const AssigningToDriverView({super.key, required this.orderId});

  @override
  State<AssigningToDriverView> createState() => _AssigningToDriverViewState();
}

class _AssigningToDriverViewState extends State<AssigningToDriverView>
    with SingleTickerProviderStateMixin {
  final SocketService socketService = Get.put(SocketService());
  final OrderFuelController orderFuelController = Get.put(OrderFuelController());

  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController with 2-minute duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 320), // 2 minutes = 120 seconds
    );

    // Create a linear animation from 0.0 to 1.0
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear, // Ensures smooth linear progression
      ),
    )..addListener(() {
      if (mounted) {
        setState(() {}); // Only update if widget is mounted
      }
    });

    // Start the animation
    _controller!.forward();

    // Socket initialization
    socketService.init().then((_) {
      if (socketService.socket.connected) {
        socketService.socket.on('orderAssigned', (data) {
          print('>>>>>>>> orderAssigned $data');
          if (data["success"] == true) {
           // _controller?.stop(); // Stop animation before navigating
            Get.offAll(() => const PaymentSuccessView());
          }
        });
        socketService.socket.on('orderResponse', (data) {
          print('>>>>>>>> orderResponse $data');
        });
        socketService.socket.on('reassignEnable', (data) {
          print('>>>>>>>> reassignEnable $data');
          if (data["status"] == true) {
            if (mounted) {
              setState(() {
                orderFuelController.reAssign.value = true; // Update reAssign only if mounted
              });
            }
          }
        });
      } else {
        print('socket not connected');
      }
    }).catchError((error) {
      print('Error initializing socket: $error');
    });
  }

  @override
  void dispose() {
    _controller?.stop(); // Stop animation if running
    _controller?.dispose(); // Dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigning to driver'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            sh30,
            LinearProgressIndicator(
              value: _animation?.value ?? 0.0, // Fallback to 0.0 if null
              minHeight: 10,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Please wait while we are assigning to the driver.',
                style: h3,
                textAlign: TextAlign.center,
              ),
            ),
            sh16,
            Obx(() => orderFuelController.reAssign.value == true
                ? CustomButton(
              text: orderFuelController.isLoading.value == true ? "Assigning..." : 'Re-Assign',
              onPressed: () {
                // Stop, reset, and restart the animation
                _controller?.stop();
                _controller?.reset();
                _controller?.forward();
                // Call the reassign method
                orderFuelController.orderReAssign(widget.orderId);
              },
              gradientColors: AppColors.gradientColorGreen,
            )
                : SizedBox())
          ],
        ),
      ),
    );
  }
}