import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../routes/route_names.dart';
import '../utils/type_def.dart';
import 'circle_image.dart';
import 'post_card_bottom_bar.dart';
import 'post_card_image.dart';
import 'post_card_top_bar.dart';


class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallBack? callBack;
  const PostCard(
      {required this.post, this.isAuthCard = false, this.callBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.10,
                child: CircleImage(
                  url: post.user?.metadata?.image,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () =>
                    Get.toNamed(RouteNames.showtwinote, arguments: post.id),
                child: SizedBox(
                  width: context.width * 0.77,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostTopBar(
                          post: post,
                          isAuthCard: isAuthCard,
                          callBack: callBack,
                        ),
                        GestureDetector(
                            onTap: () => Get.toNamed(RouteNames.showtwinote,
                                arguments: post.id),
                            child: Text(post.content!)),
                        const SizedBox(
                          height: 10,
                        ),
                        if (post.image != null)
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteNames.showimage,
                                    arguments: post.image!);
                              },
                              child: PostCardImage(url: post.image!)),
                        PostCardBottombar(post: post),
                      ]),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Color(0xff242424),
          )
        ],
      ),
    );
  }
}
