import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fourdimensions/app/modules/forgot_password_screen/controllers/forgot_password_screen_controller.dart';
import 'package:fourdimensions/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ForgotPasswordScreenView extends GetView<ForgotPasswordScreenController> {
  const ForgotPasswordScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// --- Header with background image ---
              Stack(
                children: [
                  Container(
                    height: 220.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/appbar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 220.h,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  Positioned(
                    top: 60.h,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Image.asset('assets/logos/logo.png', height: 80.h),
                        SizedBox(height: 10.h),
                        // const Text(
                        //   "Forgot Password",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 22,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),

              /// --- Email input & Send button ---
              Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      "Enter your registered email below and we'll send you a link to reset your password.",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    /// --- Email Field ---
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    /// --- Send Reset Link Button ---
                    Obx(
                      () => SizedBox(
                        width: size.width,
                        height: 45.h,
                        child: ElevatedButton(
                          onPressed:
                              controller.isButtonEnabled.value
                                  ? controller.sendResetLink
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.isButtonEnabled.value
                                    ? Colors.blueAccent
                                    : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child:
                              controller.isLoading.value
                                  ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : const Text(
                                    "Send Reset Link",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    /// --- Back to Login Button ---
                    Center(
                      child: SizedBox(
                        width: size.width * 0.5,
                        height: 45.h,
                        child: OutlinedButton(
                          onPressed: () => Get.offAllNamed(Routes.LOGIN_SCREEN),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 2,
                            shadowColor: Colors.grey.withOpacity(0.3),
                          ),
                          child: Text(
                            "Back to Login",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                        'Note that: If you did not receive the email, please check your spam folder.',
                        style: TextStyle(color: Colors.black87, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
