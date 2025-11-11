import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fourdimensions/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreenController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var isButtonEnabled = false.obs;
  var isLoading = false.obs;

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
    final isFullNameValid = fullNameController.text.isNotEmpty;
    final isEmailValid =
        emailController.text.isNotEmpty && _isValidEmail(emailController.text);
    final isPasswordValid = passwordController.text.isNotEmpty;
    final isConfirmPasswordValid = confirmPasswordController.text.isNotEmpty;

    isButtonEnabled.value =
        isFullNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid;
  }

  /// 🔹 Email format check
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// 🔹 Signup with Email Verification
  Future<void> signup() async {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // 1️⃣ Create user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user!.uid;

      // 2️⃣ Store in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': fullName,
        'email': email,
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3️⃣ Send Email Verification
      await userCredential.user!.sendEmailVerification();

      // 4️⃣ Navigate to CheckEmailScreen
      Get.offAllNamed(Routes.CHECK_EMAIL_SCREEN, arguments: uid);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'email-already-in-use') {
        message = 'Email already registered';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email';
      } else {
        message = e.message ?? 'Signup failed';
      }
      Get.snackbar(
        'Signup Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
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
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
