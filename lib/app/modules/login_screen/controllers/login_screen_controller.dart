import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fourdimensions/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isButtonEnabled = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;
  final _googleSignIn = GoogleSignIn();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Call this from the Gmail button onTap
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        Get.snackbar(
          'Cancelled',
          'Google sign-in cancelled by user',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // 2) Obtain auth details from the request
      final googleAuth = await googleUser.authentication;

      // 3) Create a new credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4) Sign in with Firebase using the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Google sign-in failed: no user.');
      }

      final userDocRef = _firestore.collection('users').doc(user.uid);
      final userData = {
        'fullName': user.displayName ?? '',
        'email': user.email ?? '',
        'photoUrl': user.photoURL ?? '',
        'isVerified': user.emailVerified,
        'provider': 'google',
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // If new user, also set createdAt
      final docSnap = await userDocRef.get();
      if (!docSnap.exists) {
        await userDocRef.set({
          ...userData,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        await userDocRef.update(userData);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', user.uid);
      await prefs.setString('email', user.email ?? '');
      await prefs.setString('name', user.displayName ?? '');
      await prefs.setString('photoUrl', user.photoURL ?? '');

      Get.offAllNamed(Routes.NEWS_HOME_SCREEN);

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String msg = 'Google sign-in failed. Try again.';

      Get.snackbar('Sign-in Error', msg, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

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

      if (!user.emailVerified) {
        Get.offAllNamed(Routes.CHECK_EMAIL_SCREEN);
        isLoading.value = false;
        return;
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        Get.snackbar('Error', 'User data not found in Firestore.');
        isLoading.value = false;
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', user.uid);
      await prefs.setString('email', user.email ?? '');
      await prefs.setString(
        'name',
        (userDoc.data() as Map<String, dynamic>?)?['fullName'] ?? '',
      );

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
