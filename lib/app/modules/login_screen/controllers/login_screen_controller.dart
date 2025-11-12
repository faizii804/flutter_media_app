import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fourdimensions/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isButtonEnabled = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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

  Future<void> login() async {
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // 🔹 Sign in with Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user == null) {
        Get.snackbar('Error', 'User not found.');
        isLoading.value = false;
        return;
      }

      // 🔹 Check Email Verification
      if (!user.emailVerified) {
        Get.offAllNamed(Routes.CHECK_EMAIL_SCREEN);
        isLoading.value = false;
        return;
      }

      // 🔹 Fetch user data from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        Get.snackbar('Error', 'User data not found in Firestore.');
        isLoading.value = false;
        return;
      }

      // 🔹 Save login info in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', user.uid);
      await prefs.setString('email', user.email ?? '');
      await prefs.setString(
        'name',
        (userDoc.data() as Map<String, dynamic>?)?['fullName'] ?? '',
      );

      // 🔹 Navigate to Home
      Get.offAllNamed(Routes.NEWS_HOME_SCREEN);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Invalid email format.';
          break;
        case 'user-not-found':
          message = 'No user found with this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password.';
          break;
        default:
          message = 'Login failed. Please try again.';
      }
      Get.snackbar('Login Error', message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
