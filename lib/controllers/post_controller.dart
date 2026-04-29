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

class PostController extends GetxController {
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
    if (file != null) image.value = file;
  }

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

  Future<void> show(int postId) async {
    try {
      showPostLoading.value = true;
      comments.value = [];
      post.value = PostModel();
      final data = await SupabaseService.client.from("posts").select('''
    id,content,image,created_at,comment_count,like_count,user_id,
    likes:likes(user_id,post_id)
''').eq("id", postId).single();
      final userData = await SupabaseService.client
          .from('users')
          .select('id,email,metadata')
          .eq('id', data['user_id'])
          .single();
      showPostLoading.value = false;
      post.value = PostModel.fromJson({...data, 'user': userData});
      postComments(postId);
    } catch (e) {
      showPostLoading.value = false;
      showSnackBar("Error", "Something went wrong please try again later!");
    }
  }

  Future<void> postComments(int postId) async {
    try {
      commentLoading.value = true;
      final List<dynamic> data =
          await SupabaseService.client.from("comments").select('''
    id,reply,created_at,user_id
''').eq("post_id", postId);
      if (data.isNotEmpty) {
        final userIds = data.map((c) => c['user_id']).toSet().toList();
        final List<dynamic> users = await SupabaseService.client
            .from('users')
            .select('id,email,metadata')
            .inFilter('id', userIds);
        final userMap = {for (var u in users) u['id']: u};
        comments.value = [
          for (var item in data)
            ReplyModel.fromJson({...item, 'user': userMap[item['user_id']]})
        ];
      }
      commentLoading.value = false;
    } catch (e) {
      commentLoading.value = false;
      showSnackBar("Error", "Something went wrong please try again later!");
    }
  }

  Future<void> likeDislike(
      String status, int postId, String postUserId, String userId) async {
    try {
      if (status == "1") {
        await SupabaseService.client
            .from("likes")
            .insert({"user_id": userId, "post_id": postId});
        await SupabaseService.client.from("notifications").insert({
          "user_id": userId,
          "notification": "liked on your post.",
          "to_user_id": postUserId,
          "post_id": postId,
        });
        await SupabaseService.client
            .rpc("like_increment", params: {"count": 1, "row_id": postId});
      } else if (status == "0") {
        await SupabaseService.client
            .from("likes")
            .delete()
            .match({"user_id": userId, "post_id": postId});
        await SupabaseService.client
            .rpc("like_decrement", params: {"count": 1, "row_id": postId});
      }
    } catch (e) {
      showSnackBar("Error", "Something went wrong!");
    }
  }

  void resetState() {
    content.value = "";
    contentController.text = "";
    image.value = null;
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
