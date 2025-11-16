import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  RxBool isNotificationEnabled = false.obs;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _setupLocalNotifications();
    _loadNotificationPreference();
  }

  // Load saved switch value
  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    isNotificationEnabled.value =
        prefs.getBool("notifications_enabled") ?? false;

    if (isNotificationEnabled.value) {
      _subscribeToNewsTopic();
    }
  }

  // Save switch value
  Future<void> _saveNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notifications_enabled", value);
  }

  // Toggle Switch
  Future<void> toggleNotifications(bool value) async {
    isNotificationEnabled.value = value;
    _saveNotificationPreference(value);

    if (value) {
      await _requestPermission();
      await _subscribeToNewsTopic();
    } else {
      await _unsubscribeFromNewsTopic();
    }
  }

  // Request Notification Permission
  Future<void> _requestPermission() async {
    final status = await Permission.notification.request();

    if (status.isGranted) {
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
    }
  }

  // Subscribe user to NEWS topic
  Future<void> _subscribeToNewsTopic() async {
    await _messaging.subscribeToTopic("news");
  }

  // Unsubscribe user
  Future<void> _unsubscribeFromNewsTopic() async {
    await _messaging.unsubscribeFromTopic("news");
  }

  // Local notification setup
  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(settings);

    // Foreground message listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (isNotificationEnabled.value) {
        _showLocalNotification(message);
      }
    });
  }

  // Display Local Notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'news_channel',
          'News Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? "New News",
      message.notification?.body ?? "Check latest update!",
      platformDetails,
    );
  }
}
