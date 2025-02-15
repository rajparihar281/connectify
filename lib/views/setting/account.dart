import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/supabase_service.dart';
import '../../utils/helper.dart';
import '../../widgets/circle_image.dart';
class Account extends StatelessWidget {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About your account"),
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                color: Color(0xff242424),
              )),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Center(
              child: Obx(
            () => CircleImage(
              url: supabaseService.currentUser.value?.userMetadata?["image"],
              radius: 60,
            ),
          )),
          const SizedBox(
            height: 10,
          ),
          Text(
            supabaseService.currentUser.value!.userMetadata!["name"],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const SizedBox(
                width: 65,
              ),
           const   Text(
                "Account Created ",
                style:  TextStyle(
                    fontSize: 20, fontWeight: FontWeight.normal),
              ),
              Text(
                formateDateFromNow(
                    supabaseService.currentUser.value!.createdAt),
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        Text("Email: ${supabaseService.currentUser.value!.email!}",
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)
          ),
       
        ])));
  }
}
