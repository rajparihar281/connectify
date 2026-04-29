import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';

class PostImagePreview extends StatelessWidget {
  PostImagePreview({super.key});
  final PostController controller = Get.find<PostController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              controller.image.value!,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
              right: 10,
              top: 10,
              child: CircleAvatar(
                backgroundColor: Colors.white38,
                child: IconButton(
                    onPressed: () {
                      controller.image.value = null;
                    },
                    icon: const Icon(Icons.close)),
              ))
        ],
      ),
    );
  }
}
