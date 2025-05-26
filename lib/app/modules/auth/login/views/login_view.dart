import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:gas_dash/app/modules/user/dashboard/views/dashboard_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../../../../../common/widgets/google_button.dart';
import '../../auth_controller/auth_controller.dart';
import '../../forgot_password/views/forgot_password_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.put(LoginController());
  AuthController authController = Get.put(AuthController());

  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey,',
                style: h2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              Text(
                'Sign in to your Account',
                style: h2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              sh12,
              Text(
                'It is quick and easy to log in. Enter your email and password below.',
                style: h4,
              ),
              sh40,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: h4),
                  sh8,
                   CustomTextField(
                    hintText: 'Your email',
                    controller: emailTEController,
                  ),
                  const SizedBox(height: 12),
                  Text('Password', style: h4),
                  sh8,
                  CustomTextField(
                    sufIcon: Image.asset(
                      AppImages.eyeClose,
                      scale: 4,
                    ),
                    hintText: '**********',
                    controller: passwordTEController,
                  ),
                ],
              ),
              sh16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //Get.to(() => const ForgotPasswordView());
                        },
                        child: Image.asset(
                          AppImages.checkBoxFilledSquare,
                          scale: 4,
                        ),
                      ),
                      sw16,
                      Text(
                        'Remember Me',
                        style: h4.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordView());
                    },
                    child: Text(
                      'Forgot password?',
                      style: h4.copyWith(color: AppColors.textColor),
                    ),
                  ),
                ],
              ),
              sh24,
              Obx(
                    () {
                  return loginController.isLoading.value == true
                      ? CustomLoader(color: AppColors.white)
                      : CustomButton(
                    text: 'Login',
                    onPressed: () {
                      loginController.userLogin(
                        email: emailTEController.text,
                        password: passwordTEController.text,
                      );
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
                    'or',
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
                onTap: () async {
                  await authController.signInWithGoogle();
                  if (authController.user.value != null) {
                    Get.offAll(()=> DashboardView());
                  } else {
                    Get.snackbar('Error', 'Google Sign-In failed');
                  }
                },
              ),
              sh12,
              GoogleButton(
                assetPath: AppImages.apple,
                label: 'Continue with Apple',
                onTap: () {},
              ),
              sh10,
              GestureDetector(
                onTap: () {
                  Get.to(() => const SignUpView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account? ',
                      style: h4,
                    ),
                    Text(
                      'Sign Up',
                      style: h4.copyWith(color: AppColors.textColor),
                    ),
                  ],
                ),
              ),
              sh20,
            ],
          ),
        ),
      ),
    );
  }
}
