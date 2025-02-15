import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/post_model.dart';
import '../models/reply_model.dart';
import '../services/navigation_service.dart';
import '../services/supabase_service.dart';
import '../utils/env.dart';
import '../utils/helper.dart';

class TwinoteController extends GetxController {
  final TextEditingController contentController =
      TextEditingController(text: "");
  var content = "".obs;
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  var showPostLoading = false.obs;
  Rx<PostModel> post = Rx<PostModel>(PostModel());
  var commentLoading = false.obs;
  RxList<ReplyModel?> comments = RxList<ReplyModel?>();

  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) {
      image.value = file;
    }
  }

  // * Add post
  Future<void> store(String userId) async {
    try {
      loading.value = true;
      const uuid = Uuid();
      final dir = "$userId/${uuid.v6()}";
      var imgPath = "";

      if (image.value != null && image.value!.existsSync()) {
        imgPath = await SupabaseService.client.storage
            .from(Env.s3Bucket)
            .upload(dir, image.value!);
      }

      // * Store post in table
      await SupabaseService.client.from("posts").insert({
        "user_id": userId,
        "content": content.value,
        "image": imgPath.isNotEmpty ? imgPath : null,
      });
      loading.value = false;
      resetState();
      Get.find<NavigationService>().currentIndex.value = 0;

      showSnackBar("Success", "Post Added successfully!");
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    } catch (error) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  // * Show Post
  Future<void> show(int postId) async {
    try {
      showPostLoading.value = true;
      comments.value = [];
      post.value = PostModel();
      final data = await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count , like_count,user_id,
    user:user_id (email , metadata) , likes:likes (user_id ,post_id)
''').eq("id", postId).single();
      showPostLoading.value = false;
      post.value = PostModel.fromJson(data);

      // * Load post comments
      postComments(postId);
    } catch (e) {
      showPostLoading.value = false;
      showSnackBar("Error", "Something went wrong please try again later!");
    }
  }

  // * fecth Post comments
  Future<void> postComments(int postId) async {
    try {
      commentLoading.value = true;
      final List<dynamic> data =
          await SupabaseService.client.from("comments").select('''
    id ,reply ,created_at ,user_id,
    user:user_id (email , metadata)
''').eq("post_id", postId);

      if (data.isNotEmpty) {
        comments.value = [for (var item in data) ReplyModel.fromJson(item)];
      }
      commentLoading.value = false;
    } catch (e) {
      commentLoading.value = false;
      showSnackBar("Error", "Something went wrong please try again later!");
    }
  }

  // * Like and dislike the post
  Future<void> likeDislike(
      String status, int postId, String postUserId, String userId) async {
    if (status == "1") {
      await SupabaseService.client
          .from("likes")
          .insert({"user_id": userId, "post_id": postId});

      // * Add like notification
      await SupabaseService.client.from("notifications").insert({
        "user_id": userId,
        "notification": "liked on your post.",
        "to_user_id": postUserId,
        "post_id": postId,
      });

      // * Increment like counter in post table
      await SupabaseService.client
          .rpc("like_increment", params: {"count": 1, "row_id": postId});
    } else if (status == "0") {
      await SupabaseService.client
          .from("likes")
          .delete()
          .match({"user_id": userId, "post_id": postId});

      // * Decrement like counter in post table
      await SupabaseService.client
          .rpc("like_decrement", params: {"count": 1, "row_id": postId});
    }
  }

  // * Reset the state
  void resetState() {
    content.value = "";
    contentController.text = "";
    image.value = null;
  }
}
