import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isButtonEnabled = false.obs;
  var rememberMe = false.obs;

  final isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    emailController.addListener(validateFields);
    passwordController.addListener(validateFields);
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void validateFields() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    isButtonEnabled.value = email.isNotEmpty && password.isNotEmpty;
  }

  void login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.offAllNamed('/news-home-screen');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
