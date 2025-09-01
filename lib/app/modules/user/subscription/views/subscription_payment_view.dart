import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/subscription/controllers/subscription_controller.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';

class SubscriptionPaymentView extends StatefulWidget {
  final String? paymentUrl;

  const SubscriptionPaymentView({
    super.key,
    this.paymentUrl,
  });

  @override
  State<SubscriptionPaymentView> createState() =>
      _SubscriptionPaymentViewState();
}

class _SubscriptionPaymentViewState extends State<SubscriptionPaymentView> {
  WebViewController? _controller;
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Payment", style: titleStyle),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageStarted: (String url) {
          debugPrint('Page start loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
          if (url.contains("confirm-payment")) {
            subscriptionController.subscriptionPaymentResults(paymentLink: url);
            debugPrint('::::::::::::: if condition ::::::::::::::::');
          }
        },
      ),
    );
  }
}
