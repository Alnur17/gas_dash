import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/login/views/login_view.dart';
import 'package:gas_dash/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/onboarding_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              OnboardingPage(
                image: AppImages.splashLogo,
                title: "Fast. Simple. Delivered to You.",
                subtitle:
                    "Highlights the flexibility of immediate or scheduled delivery, addressing the user’s timing needs.",
              ),
              OnboardingPage(
                image: AppImages.splashLogo,
                title: "Power Up Anywhere",
                subtitle:
                    "Users can refuel their vehicles no matter their location. It’s energetic and aligns with the app’s on-demand delivery promise.",
              ),
              OnboardingPage(
                image: AppImages.splashLogo,
                title: "Your Fuel, Your Way, Right Away.",
                subtitle:
                    "With our on-demand fuel delivery service, you get the right fuel, the way you want it, exactly when you need it.",
              ),
            ],
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 4.0,
                    dotWidth: Get.width * 0.25,
                    spacing: 16.0,
                    dotColor: AppColors.greyLight,
                    activeDotColor: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: AppColors.whiteDark,
                        ),
                        child: Image.asset(
                          AppImages.google,
                          scale: 4,
                        ),
                      ),
                    ),
                    sw16,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: AppColors.whiteDark,
                        ),
                        child: Image.asset(
                          AppImages.facebook,
                          scale: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                sw16,
                Expanded(
                    child: CustomButton(
                  text: 'Open Account',
                  onPressed: () {
                    Get.to(()=> SignUpView());
                  },
                      gradientColors: AppColors.gradientColor,
                )),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an accounts?',
                  style: h5.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                sw8,
                GestureDetector(
                  onTap: (){
                    Get.to(()=> LoginView());
                  },
                  child: Text(
                    'Sign in',
                    style: h5.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.textColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
