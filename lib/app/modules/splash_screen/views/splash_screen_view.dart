import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({super.key});
  final controller = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF47A6FF),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/lines.png",
              width: 250.w,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logos/logo.png",
                height: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 8.h),
              Text(
                "Where Every Headline Tells the Truth.",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
