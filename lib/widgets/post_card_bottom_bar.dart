import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/twinote_controller.dart';
import '../models/post_model.dart';
import '../routes/route_names.dart';

import '../services/supabase_service.dart';

class PostCardBottombar extends StatefulWidget {
  final PostModel post;
  const PostCardBottombar({required this.post, super.key});

  @override
  State<PostCardBottombar> createState() => _PostCardBottombarState();
}

class _PostCardBottombarState extends State<PostCardBottombar> {
  final TwinoteController controller = Get.find<TwinoteController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  String likeStatus = "";

  void likeDislike(String status) async {
    setState(() {
      likeStatus = status;
    });
    if (likeStatus == "0") {
      widget.post.likes = [];
    }
    await controller.likeDislike(status, widget.post.id!, widget.post.userId!,
        supabaseService.currentUser.value!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            likeStatus == "1" || widget.post.likes!.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      likeDislike("0");
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red[700]!,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      likeDislike("1");
                    },
                    icon: const Icon(Icons.favorite_outline),
                  ),
            IconButton(
              onPressed: () {
                Get.toNamed(RouteNames.addreply, arguments: widget.post);
              },
              icon: const Icon(Icons.chat_bubble_outline),
            ),
          ],
        ),
        Row(
          children: [
            Text("${widget.post.likeCount} Likes"),
            const SizedBox(
              width: 10,
            ),
            Text("${widget.post.commentCount!} Comments"),
          ],
        )
      ],
    );
  }
}
