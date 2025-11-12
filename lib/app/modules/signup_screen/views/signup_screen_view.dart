import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fourdimensions/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/signup_screen_controller.dart';

class SignupScreenView extends GetView<SignupScreenController> {
  const SignupScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            Colors.transparent, // 🔹 Makes status bar area transparent
        statusBarIconBrightness:
            Brightness.light, // Icons white honge (for dark bg)
      ),
    );
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// --- Header same as Login ---
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
                    ],
                  ),
                ),
              ],
            ),

            /// --- Signup Form ---
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  /// --- Full Name Field ---
                  fieldLabel("Full Name"),
                  SizedBox(height: 6.h),
                  textField(
                    controller.fullNameController,
                    hint: "Full Name",
                    icon: Icons.person_outline,
                    onChanged: (_) => controller.validateFields(),
                  ),

                  SizedBox(height: 15.h),

                  /// --- Email / Phone Field ---
                  fieldLabel("Email"),
                  SizedBox(height: 6.h),
                  textField(
                    controller.emailController,
                    hint: "Email",
                    icon: Icons.email_outlined,
                    onChanged: (_) => controller.validateFields(),
                  ),

                  SizedBox(height: 15.h),

                  /// --- Password Field ---
                  fieldLabel("Password"),
                  SizedBox(height: 6.h),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textField(
                          controller.passwordController,
                          hint: "Password",
                          icon: Icons.lock_outline,
                          obscureText: controller.isPasswordHidden.value,
                          suffix: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          onChanged: (value) {
                            controller.validateFields();
                            controller.checkPasswordStrength(value);
                          },
                        ),
                        SizedBox(height: 10.h),

                        /// --- Password Strength Indicator ---
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 8.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: controller.passwordStrength.value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: controller.passwordColor.value,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          controller.passwordLabel.value,
                          style: TextStyle(
                            color: controller.passwordColor.value,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// --- Confirm Password Field ---
                  fieldLabel("Confirm Password"),
                  SizedBox(height: 6.h),
                  Obx(
                    () => textField(
                      controller.confirmPasswordController,
                      hint: "Re-type Password",
                      icon: Icons.lock_outline,
                      obscureText: controller.isConfirmPasswordHidden.value,
                      suffix: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                      onChanged: (value) {
                        controller.validateFields();
                        controller.checkPasswordMatch(value);
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () =>
                        controller.passwordMatchMessage.value.isNotEmpty
                            ? Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 6.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                color: controller.passwordMatchColor.value
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: controller.passwordMatchColor.value,
                                ),
                              ),
                              child: Text(
                                controller.passwordMatchMessage.value,
                                style: TextStyle(
                                  color: controller.passwordMatchColor.value,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            )
                            : const SizedBox(),
                  ),

                  SizedBox(height: 25.h),

                  /// --- Submit Button ---
                  Obx(
                    () => SizedBox(
                      width: size.width,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed:
                            controller.isButtonEnabled.value
                                ? () => controller.signup()
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          disabledBackgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child:
                            controller.isLoading.value
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text(
                                  'Create Account',
                                  style: TextStyle(color: Colors.white),
                                ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15.h),

                  /// --- Already Have Account ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.LOGIN_SCREEN),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- Custom Widgets ---

  Widget fieldLabel(String text) {
    return RichText(
      text: TextSpan(
        text: "$text ",
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(text: "*", style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget textField(
    TextEditingController controller, {
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffix,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
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
      onChanged: onChanged,
    );
  }
}
