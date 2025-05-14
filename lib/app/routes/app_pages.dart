import 'package:get/get.dart';

import '../modules/auth/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/auth/forgot_password/views/forgot_password_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/onboarding/views/onboarding_view.dart';
import '../modules/auth/sign_up/bindings/sign_up_binding.dart';
import '../modules/auth/sign_up/views/sign_up_view.dart';
import '../modules/auth/splash/bindings/splash_binding.dart';
import '../modules/auth/splash/views/splash_view.dart';
import '../modules/driver/driver_dashboard/bindings/driver_dashboard_binding.dart';
import '../modules/driver/driver_dashboard/views/driver_dashboard_view.dart';
import '../modules/driver/driver_earning/bindings/driver_earning_binding.dart';
import '../modules/driver/driver_earning/views/driver_earning_view.dart';
import '../modules/driver/driver_history/bindings/driver_history_binding.dart';
import '../modules/driver/driver_history/views/driver_history_view.dart';
import '../modules/driver/driver_home/bindings/driver_home_binding.dart';
import '../modules/driver/driver_home/views/driver_home_view.dart';
import '../modules/driver/driver_message/bindings/driver_message_binding.dart';
import '../modules/driver/driver_message/views/driver_message_view.dart';
import '../modules/driver/driver_profile/bindings/driver_profile_binding.dart';
import '../modules/driver/driver_profile/views/driver_profile_view.dart';
import '../modules/user/dashboard/bindings/dashboard_binding.dart';
import '../modules/user/dashboard/views/dashboard_view.dart';
import '../modules/user/home/bindings/home_binding.dart';
import '../modules/user/home/views/home_view.dart';
import '../modules/user/message/bindings/message_binding.dart';
import '../modules/user/message/views/message_view.dart';
import '../modules/user/order_history/bindings/order_history_binding.dart';
import '../modules/user/order_history/views/order_history_view.dart';
import '../modules/user/profile/bindings/profile_binding.dart';
import '../modules/user/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => const OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_DASHBOARD,
      page: () => const DriverDashboardView(),
      binding: DriverDashboardBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_HOME,
      page: () => const DriverHomeView(),
      binding: DriverHomeBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_HISTORY,
      page: () => const DriverHistoryView(),
      binding: DriverHistoryBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_EARNING,
      page: () => const DriverEarningView(),
      binding: DriverEarningBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_MESSAGE,
      page: () => const DriverMessageView(),
      binding: DriverMessageBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_PROFILE,
      page: () => const DriverProfileView(),
      binding: DriverProfileBinding(),
    ),
  ];
}
