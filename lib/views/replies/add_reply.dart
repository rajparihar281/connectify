import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/reply_controller.dart';
import '../../models/post_model.dart';
import '../../services/supabase_service.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/post_card_image.dart';

class AddReply extends StatefulWidget {
  const AddReply({super.key});

  @override
  State<AddReply> createState() => _AddReplyState();
}

class _AddReplyState extends State<AddReply> {
  final PostModel post = Get.arguments;
  final ReplyController controller = Get.put(ReplyController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  void addReply() {
    if (controller.replycontroller.text.isNotEmpty) {
      controller.addReply(
        supabaseService.currentUser.value!.id,
        post.id!,
        post.userId!,
      );
    }
      Get.back(); 

  }
@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Comment",
        ),
        actions: [
          TextButton(
            onPressed: addReply,
            child: Obx(
              () => controller.loading.value
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Post",
                      style: TextStyle(
                        fontWeight: controller.reply.value.isNotEmpty
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleImage(url: post.user?.metadata?.image),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user!.metadata!.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(post.content!),
                  // Display the post image if has any
                  if (post.image != null) PostCardImage(url: post.image!),
                  TextField(
                    autofocus: true,
                    controller: controller.replycontroller,
                    onChanged: (value) => controller.reply.value = value,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 10,
                    minLines: 1,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      hintText:
                          "Commenting on ${post.user!.metadata!.name!} post",
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
