import 'package:get/get.dart';

import '../controllers/news_home_screen_controller.dart';

class NewsHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsHomeScreenController>(
      () => NewsHomeScreenController(),
    );
  }
}
