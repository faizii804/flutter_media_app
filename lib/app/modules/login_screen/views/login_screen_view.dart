import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  LoginScreenView({super.key});
  final controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
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

            /// --- Login Form ---
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  /// --- Email / Phone Field ---
                  /// --- Email / Phone Field ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Email / Phone Number ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          children: const [
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          hintText: 'Email / Phone Number',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                          prefixIcon: const Icon(Icons.person_outline),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (_) => controller.validateFields(),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// --- Password Field ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Password ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          children: const [
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Obx(
                        () => TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: controller.passwordController,
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (_) => controller.validateFields(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  /// --- Remember Me + Forgot Password ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.rememberMe.value,
                              onChanged: controller.toggleRememberMe,
                            ),
                          ),
                          const Text(
                            'Remember Me',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  /// --- Sign In Button ---
                  Obx(
                    () => SizedBox(
                      width: size.width,
                      height: 35.h,
                      child: ElevatedButton(
                        onPressed:
                            (controller.isButtonEnabled.value &&
                                    !controller.isLoading.value)
                                ? controller.login
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              controller.isLoading.value
                                  ? Colors.black
                                  : Colors.blueAccent,
                          disabledBackgroundColor: Colors.grey[300],
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
                                  'Sign In',
                                  style: TextStyle(color: Colors.white),
                                ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),

                  /// --- Sign Up Button ---
                  SizedBox(
                    width: size.width,
                    height: 35.h,
                    child: OutlinedButton(
                      onPressed: () => Get.toNamed('/signup-screen'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// --- Social Login Section ---
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Or sign in using',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(height: 15.h),

                        // 🔹 Only Gmail Button Centered
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.5,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Image.asset(
                                'assets/logos/gmaillogo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
