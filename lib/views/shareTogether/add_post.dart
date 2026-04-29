import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../controllers/post_controller.dart';
import '../../services/supabase_service.dart';
import '../../widgets/add_app_bar.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/post_image_preview.dart';

// ignore: must_be_immutable
class AddPost extends StatelessWidget {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final PostController controller = Get.put(PostController());

  AddPost({super.key});
  File? galleryFile;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AddAppBar(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => CircleImage(
                      url: supabaseService
                          .currentUser.value!.userMetadata?["image"],
                    )),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: context.width * 0.80,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              supabaseService
                                  .currentUser.value!.userMetadata?["name"],
                            )),
                        TextField(
                          autofocus: true,
                          onChanged: (value) =>
                              controller.content.value = value,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 10,
                          minLines: 1,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                            hintText: "Post something great",
                            border: InputBorder.none,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => controller.pickImage(),
                              child: const Icon(Icons.collections, size: 30),
                            ),
                          ],
                        ),

                        //*  To Preview user image * //
                        Obx(() => Column(
                              children: [
                                if (controller.image.value != null)
                                  PostImagePreview()
                              ],
                            )),
                      ]),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
