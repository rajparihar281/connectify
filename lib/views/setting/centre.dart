import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/route_names.dart';
import '../../services/supabase_service.dart';

class Centre extends StatelessWidget {
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  Centre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Centre"),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Color(0xff242424),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ListTile(
                onTap: () {
                  Get.toNamed(RouteNames.account);
                },
                title: const Text("About your account"),
                trailing: const Icon(Icons.arrow_forward_ios_sharp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
