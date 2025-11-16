import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fourdimensions/app/modules/news_home_screen/controllers/notification_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DrawerItemSettings extends StatelessWidget {
  DrawerItemSettings({super.key});

  final NotificationController notifController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SETTINGS
        ExpansionTile(
          leading: Icon(Icons.settings, color: Colors.black87),
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
          children: [
            Obx(
              () => SwitchListTile(
                title: Text("Notification Preferences"),
                value: notifController.isNotificationEnabled.value,
                onChanged: (value) {
                  notifController.toggleNotifications(value);
                },
              ),
            ),
            ListTile(title: Text("Clear Cache")),
            ListTile(title: Text("Dark Mode")),
          ],
        ),

        // SUPPORT
        ExpansionTile(
          leading: Icon(Icons.support_agent, color: Colors.black87),
          title: Text(
            "Support",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
          children: const [
            ListTile(title: Text("Report a Bug")),
            ListTile(title: Text("Send Feedback")),
            ListTile(title: Text("Contact Support")),
          ],
        ),

        // LEGAL
        ExpansionTile(
          leading: Icon(Icons.privacy_tip, color: Colors.black87),
          title: Text(
            "Legal",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
          children: const [
            ListTile(title: Text("Privacy Policy")),
            ListTile(title: Text("Terms & Conditions")),
          ],
        ),

        // ABOUT
        ExpansionTile(
          leading: Icon(Icons.adb_outlined, color: Colors.black87),
          title: Text(
            "About",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
          children: const [
            ListTile(title: Text("App version")),
            ListTile(title: Text("About Us")),
          ],
        ),
      ],
    );
  }
}
