import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../routes/route_names.dart';
import '../utils/styles/button_stye.dart';
import 'circle_image.dart';


class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: CircleImage(
          url: user.metadata?.image,
        ),
      ),
      title: Text(user.metadata!.name!),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: OutlinedButton(
        onPressed: () =>
            Get.toNamed(RouteNames.showprofile, arguments: user.id),
        style: customOutLineStyle(),
        child: const Text("View Profile"),
      ),
    );
  }
}
