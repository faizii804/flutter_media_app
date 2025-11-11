import 'package:get/get.dart';

import '../controllers/check_email_screen_controller.dart';

class CheckEmailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckEmailScreenController>(
      () => CheckEmailScreenController(),
    );
  }
}
