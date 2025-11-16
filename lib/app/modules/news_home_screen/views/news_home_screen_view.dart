import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fourdimensions/app/widgets/drawer_items_settings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controllers/news_home_screen_controller.dart';
import '../models/news_model.dart';
import '../../news_detail_screen_view/views/news_detail_screen_view_view.dart';
import '../../../routes/app_pages.dart';
import '../../login_screen/controllers/login_screen_controller.dart';

class NewsHomeScreenView extends GetView<NewsHomeScreenController> {
  NewsHomeScreenView({super.key});
  final controller = Get.put(NewsHomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logos/logo.png',
              height: 40.h,
              width: 40.w,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8.w),
            const Text(
              "4 Dimensions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Obx(() {
        final news = controller.newsList;
        final isLoading = controller.isLoading.value;

        if (isLoading) {
          // Jab data fetch ho raha ho
          return const Center(child: CircularProgressIndicator());
        } else if (news.isEmpty) {
          // Jab news empty ho
          return Center(
            child: Text(
              "There is no news available yet.",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          // Jab news available ho
          return SingleChildScrollView(
            padding: EdgeInsets.all(12.0.w),
            child: Column(
              children: [
                if (news.isNotEmpty) _buildFeaturedCard(news.first),
                SizedBox(height: 12.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: news.length - 1,
                  itemBuilder: (context, index) {
                    return _buildNewsCard(news[index + 1]);
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[900]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 80.h,
                    width: 80.w,
                    child: Image.asset(
                      'assets/logos/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    '4 Dimensions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ⭐ NEW COLLAPSIBLE MENU ⭐
          ExpansionTile(
            leading: Icon(Icons.newspaper, color: Colors.black87),
            title: Text(
              "All UK News",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            childrenPadding: EdgeInsets.only(left: 20.w),

            children: [
              _drawerItem(Icons.home, "Home", "All"),
              _drawerItem(Icons.public, "World", "World"),
              _drawerItem(Icons.sports_soccer, "Sports", "Sports"),
              _drawerItem(Icons.movie, "Entertainment", "Entertainment"),
              _drawerItem(Icons.currency_bitcoin, "Crypto News", "Crypto"),
            ],
          ),
          DrawerItemSettings(),

          // const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: _performLogout,
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, String category) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Get.back();
        controller.changeCategory(category);
      },
    );
  }

  Widget _buildFeaturedCard(NewsModel news) {
    return GestureDetector(
      onTap: () => Get.to(() => NewsDetailScreenViewView(news: news)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5.r,
              spreadRadius: 1.r,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
              child: Image.network(
                news.imageUrl,
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Time/Source text
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(minutes: 1)),
                    builder: (context, snapshot) {
                      final formattedTime = timeago.format(
                        news.timestamp.toDate(),
                      );
                      return Text(
                        "Published $formattedTime",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(NewsModel news) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: () => Get.to(() => NewsDetailScreenViewView(news: news)),
      child: Container(
        margin: EdgeInsets.only(bottom: 14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2.r,
              blurRadius: 8.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.network(
                news.imageUrl,
                width: 120.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          timeago.format(news.timestamp.toDate()),
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performLogout() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (Get.isRegistered<NewsHomeScreenController>()) {
        Get.delete<NewsHomeScreenController>();
      }
      if (Get.isRegistered<LoginScreenController>()) {
        Get.delete<LoginScreenController>();
      }

      if (Get.isDialogOpen ?? false) Get.back();

      Get.offAllNamed(Routes.LOGIN_SCREEN);
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      print("Logout Error: $e");
    }
  }
}
