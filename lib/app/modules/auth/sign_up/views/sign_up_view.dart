import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/login/views/login_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/sign_up_body_widget.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/google_button.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Image.asset(
                  AppImages.splashLogo,
                  scale: 4,
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
                sh12,
                Text(
                  'Register your Account',
                  style: h2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                sh12,
                const SignUpBodyWidget(),
                sh16,
                Row(
                  children: [
                    Image.asset(
                      AppImages.checkBoxFilled,
                      scale: 4,
                    ),
                    sw5,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'By agreeing to the ', style: h4),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //Get.to(() => TermsAndConditionsView());
                              },
                            text: 'Terms & Condition',
                            style: h4.copyWith(color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                sh24,
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    //controller.onSignupComplete();
                  },
                  gradientColors: AppColors.gradientColor,
                ),
                sh10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: Divider()),
                    sw10,
                    Text(
                      'Or sign in with',
                      style: h4,
                    ),
                    sw10,
                    const Expanded(child: Divider()),
                  ],
                ),
                sh10,
                GoogleButton(
                  assetPath: AppImages.google,
                  label: 'Continue with Google',
                  onTap: () {},
                ),
                sh24,
                GoogleButton(
                  assetPath: AppImages.facebook,
                  label: 'Continue with Facebook',
                  onTap: () {},
                ),
                sh20,
                GestureDetector(
                  onTap: () {
                    Get.offAll(
                      () => const LoginView(),
                      transition: Transition.fadeIn,
                      duration: Duration(milliseconds: 500),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account? ',
                        style: h4,
                      ),
                      Text(
                        'Sign In',
                        style: h4.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                sh30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
