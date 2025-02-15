import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../../services/supabase_service.dart';
import '../../widgets/circle_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  final ProfileController profileController = Get.find<ProfileController>();
  final TextEditingController textEditingController =
      TextEditingController(text: "");
  final TextEditingController nameEditingController =
      TextEditingController(text: "");
  final TextEditingController emailEditingController =
      TextEditingController(text: "");

  @override
  void initState() {
    nameEditingController.text =
        supabaseService.currentUser.value?.userMetadata?["name"] ?? " ";
    textEditingController.text =
        supabaseService.currentUser.value?.userMetadata?["description"] ?? " ";
    emailEditingController.text =
        supabaseService.currentUser.value?.userMetadata?["email"] ?? " ";
    super.initState();
  }

  @override
  void dispose() {
    profileController.dispose();
    nameEditingController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          Obx(() => TextButton(
                onPressed: () {
                  profileController.updateProfile(
                      supabaseService.currentUser.value!.id,
                      textEditingController.text,
                      nameEditingController.text);
                },
                child: profileController.loading.value
                    ? const SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator.adaptive())
                    : const Text(
                        "Done",
                        style: TextStyle(fontSize: 16),
                      ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Center(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    if (profileController.image.value != null)
                      CircleImage(
                        path: profileController.image.value,
                        radius: 70,
                      )
                    else
                      CircleImage(
                        url: supabaseService
                            .currentUser.value?.userMetadata?["image"],
                        radius: 70,
                      ),
                    CircleAvatar(
                      backgroundColor: Colors.white60,
                      child: IconButton(
                        onPressed: () {
                          profileController.pickImage();
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameEditingController,
              maxLength: 20,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                label: Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                hintText: "Enter your Name",
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            TextFormField(
              controller: textEditingController,
              maxLength: 50,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                label: Text(
                  "Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                hintText: "Enter your description",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
