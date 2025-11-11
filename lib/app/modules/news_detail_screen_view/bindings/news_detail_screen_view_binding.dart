import 'package:get/get.dart';

import '../controllers/news_detail_screen_view_controller.dart';

class NewsDetailScreenViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailScreenViewController>(
      () => NewsDetailScreenViewController(),
    );
  }
}
