import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/post_controller.dart';
import '../../widgets/loading.dart';
import '../../widgets/post_card.dart';
import '../../widgets/reply_card.dart';

class ShowPost extends StatefulWidget {
  const ShowPost({super.key});

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  final int postId = Get.arguments;
  final PostController controller = Get.put(PostController());

  @override
  void initState() {
    controller.show(postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => controller.showPostLoading.value
              ? const Loading()
              : Column(
                  children: [
                    PostCard(post: controller.post.value),

                    const SizedBox(height: 20),
                    // * load thread comments
                    if (controller.commentLoading.value)
                      const Loading()
                    else if (controller.comments.isNotEmpty &&
                        controller.commentLoading.value == false)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.comments.length,
                        itemBuilder: (context, index) =>
                            ReplyCard(reply: controller.comments[index]!),
                      )
                    else
                      const Text("No Comments")
                  ],
                ),
        ),
      ),
    );
  }
}
