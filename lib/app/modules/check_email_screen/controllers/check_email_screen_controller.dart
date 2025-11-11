import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fourdimensions/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckEmailScreenController extends GetxController {
  var isLoading = false.obs;
  var isVerified = false.obs;
  late String uid;

  /// 🔹 Check if user has verified email
  Future<void> checkVerification() async {
    isLoading.value = true;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      if (user != null && user.emailVerified) {
        isVerified.value = true;

        // Update Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'isVerified': true,
        });

        // Save login info
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', uid);

        // Navigate to HomeScreen
        Get.offAllNamed(Routes.LOGIN_SCREEN);
      } else {
        Get.snackbar(
          'Not Verified',
          'Please verify your email first',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
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

  /// 🔹 Resend verification email
  Future<void> resendEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      Get.snackbar(
        'Email Sent',
        'Verification email has been resent',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend email: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    uid = Get.arguments ?? '';
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
