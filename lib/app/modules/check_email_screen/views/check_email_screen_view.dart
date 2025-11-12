import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fourdimensions/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/check_email_screen_controller.dart';

class CheckEmailScreenView extends GetView<CheckEmailScreenController> {
  CheckEmailScreenView({super.key});
  @override
  final controller = Get.put(CheckEmailScreenController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// --- Custom AppBar with background image ---
              Stack(
                children: [
                  Container(
                    height: 220.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/appbar.png',
                        ), // 🔹 your header image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 220.h,
                    width: double.infinity,
                    color: Colors.black.withOpacity(
                      0.3,
                    ), // light overlay for readability
                  ),
                  Positioned(
                    top: 60.h,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Image.asset('assets/logos/logo.png', height: 80.h),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 15.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          border: Border.all(color: Colors.blue, width: 1.5),
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'A verification link has been sent to your email. '
                          'Please check your inbox and click the link to activate your account.',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // 🔹 Second Container: Check spam message
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                          horizontal: 15.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          border: Border.all(color: Colors.orange, width: 1.5),
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          'If you did not receive the email, please check your spam folder.',
                          style: TextStyle(color: Colors.black87, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : controller.checkVerification,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient:
                                    controller.isLoading.value
                                        ? LinearGradient(
                                          colors: [
                                            Colors.blue.shade300,
                                            Colors.blue.shade200,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                        : LinearGradient(
                                          colors: [
                                            Colors.blue.shade600,
                                            Colors.blue.shade400,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child:
                                    controller.isLoading.value
                                        ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                        : const Text(
                                          'I have verified',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 45.h,
                        child: OutlinedButton(
                          onPressed: controller.resendEmail,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.orange.shade400,
                              width: 1.8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            backgroundColor: Colors.orange.shade50,
                          ),
                          child: const Text(
                            'Resend Email',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 45.h,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.offAllNamed(
                              Routes.SIGNUP_SCREEN,
                            ); // ⬅️ Wapas previous screen
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey.shade500,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          child: const Text(
                            "I don't want to verify, Go Back",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
