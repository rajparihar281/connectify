import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../routes/route_names.dart';
import '../utils/helper.dart';
import '../utils/type_def.dart';

class PostTopBar extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallBack? callBack;
  const PostTopBar(
      {required this.post, this.isAuthCard = false, this.callBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () =>
                Get.toNamed(RouteNames.showprofile, arguments: post.userId),
            child: Text(
              post.user!.metadata!.name!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        Row(
          children: [
            Text(formateDateFromNow(post.createdAt!)),
            const SizedBox(
              width: 10,
            ),
            isAuthCard
                ? GestureDetector(
                    onTap: () {
                      confirmBox("Are you sure ?",
                          "Once it is deleted you cannot get your post back",
                          () {
                        callBack!(post.id!);
                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : IconButton(onPressed: () => {}, icon: const Icon(Icons.more_horiz))
          ],
        )
      ],
    );
  }
}
