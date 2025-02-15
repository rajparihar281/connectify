import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/route_names.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
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
                Get.toNamed(RouteNames.privacy);
              },
              title: const Text("Privacy Policy"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(RouteNames.terms);
              },
              title: const Text("Terms of use"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
