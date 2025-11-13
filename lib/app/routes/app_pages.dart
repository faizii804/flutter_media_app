import 'package:get/get.dart';

import '../modules/check_email_screen/bindings/check_email_screen_binding.dart';
import '../modules/check_email_screen/views/check_email_screen_view.dart';
import '../modules/forgot_password_screen/bindings/forgot_password_screen_binding.dart';
import '../modules/forgot_password_screen/views/forgot_password_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_screen/bindings/login_screen_binding.dart';
import '../modules/login_screen/views/login_screen_view.dart';
import '../modules/news_detail_screen_view/bindings/news_detail_screen_view_binding.dart';
import '../modules/news_detail_screen_view/views/news_detail_screen_view_view.dart';
import '../modules/news_home_screen/bindings/news_home_screen_binding.dart';
import '../modules/news_home_screen/views/news_home_screen_view.dart';
import '../modules/signup_screen/bindings/signup_screen_binding.dart';
import '../modules/signup_screen/views/signup_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_SCREEN,
      page: () => SignupScreenView(),
      binding: SignupScreenBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_HOME_SCREEN,
      page: () => NewsHomeScreenView(),
      binding: NewsHomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL_SCREEN_VIEW,
      page: () => NewsDetailScreenViewView(news: Get.arguments),
      binding: NewsDetailScreenViewBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_EMAIL_SCREEN,
      page: () => CheckEmailScreenView(),
      binding: CheckEmailScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_SCREEN,
      page: () => ForgotPasswordScreenView(),
      binding: ForgotPasswordScreenBinding(),
    ),
  ];
}
