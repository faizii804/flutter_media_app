import 'package:fourdimensions/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  final count = 0.obs;

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 5));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(Routes.NEWS_HOME_SCREEN);
    } else {
      Get.offAllNamed(Routes.LOGIN_SCREEN);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }
}

@override
void onReady() {}

@override
void onClose() {}
