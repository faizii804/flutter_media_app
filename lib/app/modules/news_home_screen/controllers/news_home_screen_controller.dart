import 'package:fourdimensions/app/modules/news_home_screen/models/news_model.dart';
import 'package:get/get.dart';

class NewsHomeScreenController extends GetxController {
  var newsList = <NewsModel>[].obs;

  void loadManualNews() {
    newsList.value = [
      NewsModel(
        title: "Breaking: Flutter 4.0 Released with Major Improvements!",
        imageUrl: "https://picsum.photos/id/1018/400/200",
        time: "2h ago",
        isFeatured: true,
      ),
      NewsModel(
        title: "Pakistan wins by 10 wickets in World Cup final!",
        imageUrl: "https://picsum.photos/id/1025/400/200",
        time: "3h ago",
        isFeatured: false,
      ),
      NewsModel(
        title: "New AI model sets benchmark in coding speed",
        imageUrl: "https://picsum.photos/id/1032/400/200",
        time: "5h ago",
        isFeatured: false,
      ),
      NewsModel(
        title: "NASA discovers possible signs of life on Europa",
        imageUrl: "https://picsum.photos/id/1003/400/200",
        time: "7h ago",
        isFeatured: false,
      ),
      NewsModel(
        title: "Breaking: Flutter 4.0 Released with Major Improvements!",
        imageUrl: "https://picsum.photos/id/1018/400/200",
        time: "2h ago",
        isFeatured: true,
      ),
      NewsModel(
        title: "Pakistan wins by 10 wickets in World Cup final!",
        imageUrl: "https://picsum.photos/id/1025/400/200",
        time: "3h ago",
        isFeatured: false,
      ),
    ];
  }

  final count = 0.obs;
  @override
  void onInit() {
    loadManualNews();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    newsList.close();
    super.onClose();
  }

  void increment() => count.value++;
}
