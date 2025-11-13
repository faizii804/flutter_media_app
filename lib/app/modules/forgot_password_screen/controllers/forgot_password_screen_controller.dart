import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreenController extends GetxController {
  final emailController = TextEditingController();

  var isButtonEnabled = false.obs;
  var isLoading = false.obs;

  final _auth = FirebaseAuth.instance;

  /// Enable button only if email is valid
  void validateEmail() {
    final email = emailController.text.trim();
    isButtonEnabled.value = email.isNotEmpty && GetUtils.isEmail(email);
  }

  /// Send Firebase password reset link
  Future<void> sendResetLink() async {
    final email = emailController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Invalid Email', 'Please enter a valid email address');
      return;
    }

    try {
      isLoading.value = true;

      await _auth.sendPasswordResetEmail(email: email);

      // If success
      Get.snackbar(
        'Check Your Email',
        'If an account exists for $email, a password reset link has been sent. '
            'Please check your inbox and spam folder.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade200,
        colorText: Colors.black,
        duration: const Duration(seconds: 5),
      );
      emailController.clear();
    } on FirebaseAuthException catch (e) {
      // Catch specific Firebase errors
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found with this email.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      } else {
        message = 'Failed to send reset link. Try again.';
      }

      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade200,
        colorText: Colors.black,
      );
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    emailController.addListener(validateEmail);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
