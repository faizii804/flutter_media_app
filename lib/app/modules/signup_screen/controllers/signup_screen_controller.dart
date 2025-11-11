import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupScreenController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var isButtonEnabled = false.obs;

  /// 🔹 Password Strength (0 to 1 scale)
  var passwordStrength = 0.0.obs;
  var passwordLabel = ''.obs;
  var passwordColor = Colors.transparent.obs;

  var passwordMatchMessage = ''.obs;
  var passwordMatchColor = Colors.transparent.obs;

  void checkPasswordMatch(String value) {
    if (value.isEmpty) {
      passwordMatchMessage.value = '';
      passwordMatchColor.value = Colors.transparent;
    } else if (value == passwordController.text) {
      passwordMatchMessage.value = 'Password matched';
      passwordMatchColor.value = Colors.green;
    } else {
      passwordMatchMessage.value = 'Passwords do not match';
      passwordMatchColor.value = Colors.red;
    }
  }

  /// 🔹 Calculate Password Strength
  void checkPasswordStrength(String password) {
    double strength = 0.0;

    if (password.isEmpty) {
      passwordStrength.value = 0.0;
      passwordLabel.value = '';
      passwordColor.value = Colors.transparent;
      return;
    }

    // Base strength by length
    if (password.length <= 5) {
      strength = 0.3;
      passwordLabel.value = "Weak";
      passwordColor.value = Colors.red;
    } else if (password.length <= 8) {
      strength = 0.6;
      passwordLabel.value = "Medium";
      passwordColor.value = Colors.orange;
    } else {
      strength = 1.0;
      passwordLabel.value = "Strong";
      passwordColor.value = Colors.green;
    }

    passwordStrength.value = strength;
  }

  /// 🔹 Toggle Password Visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  /// 🔹 Toggle Confirm Password Visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void validateFields() {
    final isValid =
        fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
    isButtonEnabled.value = isValid;
  }

  void signup() {
    // TODO: Add backend signup logic later
    Get.snackbar(
      "Signup Successful",
      "Account created successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
