import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/twinote_controller.dart';
import '../../widgets/loading.dart';
import '../../widgets/post_card.dart';
import '../../widgets/reply_card.dart';

class ShowTwinote extends StatefulWidget {
  const ShowTwinote({super.key});

  @override
  State<ShowTwinote> createState() => _ShowTwinoteState();
}

class _ShowTwinoteState extends State<ShowTwinote> {
  final int postId = Get.arguments;
  final TwinoteController controller = Get.put(TwinoteController());

  @override
  void initState() {
    controller.show(postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twinote"),
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
