import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
        bottom:const PreferredSize(
            preferredSize: Size.fromHeight(2),
            child: Divider(
              color: Color(0xff242424),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {},
              title: const Text("Report a problem"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Help Centre"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
            ListTile(
              onTap: () {},
              title: const Text("Support Request"),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
