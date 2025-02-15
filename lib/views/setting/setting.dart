import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/setting_controller.dart';
import '../../routes/route_names.dart';
import '../../utils/helper.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Color(0xff242424),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Get.toNamed(RouteNames.help);
              },
              leading: const Icon(Icons.help_outline_outlined),
              title: const Text("Help"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(RouteNames.about);
              },
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text("About"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(RouteNames.centre);
              },
              leading: const Icon(Icons.groups_2_outlined),
              title: const Text("Account Center"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
            ListTile(
              onTap: () {
                confirmBox("Are you sure",
                    "This action will logout you from this device", () {
                  settingController.logout();
                });
              },
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
