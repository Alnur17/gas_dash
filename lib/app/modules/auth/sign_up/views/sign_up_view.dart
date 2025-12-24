import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/login/views/login_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/terms_and_conditions_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/sign_up_body_widget.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../auth_controller/auth_controller.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
   SignUpView({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final SignUpController signupController = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Image.asset(
          AppImages.splashLogo,
          scale: 4,
          height: 100,
          width: 100,
          fit: BoxFit.contain,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register your Account',
                style: h2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              //sh12,
              const SignUpBodyWidget(),
              //sh16,
              Row(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        signupController.toggleCheckboxVisibility();
                      },
                      child: Image.asset(
                        signupController.isCheckboxVisible.value
                            ? AppImages.checkBoxFilledSquare
                            : AppImages.checkBox,
                        scale: 4,
                      ),
                    ),
                  ),
                  sw12,
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'By agreeing to the ', style: h4),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => TermsAndConditionsView());
                              },
                            text: 'Terms & Condition',
                            style: h4.copyWith(color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              sh24,
              Obx(
                () {
                  return signupController.isLoading.value == true
                      ? CustomLoader(color: AppColors.white)
                      : CustomButton(
                          text: 'Sign Up',
                          onPressed: () async {
                            await signupController.registerUser();
                          },
                          gradientColors: AppColors.gradientColor,
                        );
                },
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
              // sh10,
              // GoogleButton(
              //   assetPath: AppImages.google,
              //   label: 'Continue with Google',
              //   onTap: () {
              //     authController.loginWithGoogle();
              //   },
              // ),
        /*      sh12,
              GoogleButton(
                assetPath: AppImages.apple,
                label: 'Continue with Apple',
                onTap: () {},
              ),*/
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
    );
  }
}
