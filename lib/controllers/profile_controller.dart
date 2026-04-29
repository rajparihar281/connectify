import 'dart:io';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';
import '../models/reply_model.dart';
import '../models/user_model.dart';
import '../services/supabase_service.dart';
import '../utils/env.dart';
import '../utils/helper.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  var postLoading = false.obs;
  RxList<PostModel> posts = RxList<PostModel>();
  var replyLoading = false.obs;
  RxList<ReplyModel> replies = RxList<ReplyModel>();
  var userLoading = false.obs;
  Rx<UserModel> user = Rx<UserModel>(UserModel());

  Future<void> updateProfile(
      String userId, String description, String name) async {
    try {
      loading.value = true;
      if (image.value != null && image.value!.existsSync()) {
        final String dir = "$userId/profile.jpg";
        final String path =
            await SupabaseService.client.storage.from(Env.s3Bucket).upload(
                  dir,
                  image.value!,
                  fileOptions: const FileOptions(upsert: true),
                );
        await SupabaseService.client.auth.updateUser(
          UserAttributes(data: {"image": path}),
        );
      }
      await SupabaseService.client.auth.updateUser(
        UserAttributes(data: {"description": description, "name": name}),
      );
      loading.value = false;
      image.value = null;
      Get.back();
      showSnackBar("Success", "Profile Updated Successfully!");
    } on AuthException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    }
  }

  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) image.value = file;
  }

  void fetchUser(String userId) async {
    try {
      userLoading.value = true;
      final response = await SupabaseService.client
          .from("users")
          .select("id,email,metadata")
          .eq("id", userId)
          .single();
      userLoading.value = false;
      user.value = UserModel.fromJson(response);
      fetchUserPost(userId);
      fetchReplies(userId);
    } catch (e) {
      userLoading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

  void fetchUserPost(String userId) async {
    try {
      postLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("posts").select('''
    id,content,image,created_at,comment_count,like_count,user_id,
    likes:likes(user_id,post_id)
''').eq("user_id", userId).order("id", ascending: false);
      postLoading.value = false;
      if (response.isNotEmpty) {
        final userData = await SupabaseService.client
            .from('users')
            .select('id,email,metadata')
            .eq('id', userId)
            .single();
        posts.value = [
          for (var item in response)
            PostModel.fromJson({...item, 'user': userData})
        ];
      } else {
        posts.value = [];
      }
    } catch (e) {
      postLoading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

  void fetchReplies(String userId) async {
    try {
      replyLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("comments").select('''
id,user_id,post_id,reply,created_at
''').eq("user_id", userId).order("id", ascending: false);
      replyLoading.value = false;
      if (response.isNotEmpty) {
        final userData = await SupabaseService.client
            .from('users')
            .select('id,email,metadata')
            .eq('id', userId)
            .single();
        replies.value = [
          for (var item in response)
            ReplyModel.fromJson({...item, 'user': userData})
        ];
      } else {
        replies.value = [];
      }
    } catch (e) {
      replyLoading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      loading.value = true;
      await SupabaseService.client.from("posts").delete().eq("id", postId);
      loading.value = false;
      posts.removeWhere((element) => element.id == postId);
      if (Get.isDialogOpen == true) Get.back();
      showSnackBar("Success", "Post deleted successfully");
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

  Future<void> deleteComment(int commentId) async {
    try {
      loading.value = true;
      await SupabaseService.client
          .from("comments")
          .delete()
          .eq("id", commentId);
      await SupabaseService.client
          .rpc("comment_decrement", params: {"count": 1, "row_id": commentId});
      loading.value = false;
      replies.removeWhere((element) => element.id == commentId);
      if (Get.isDialogOpen == true) Get.back();
      showSnackBar("Success", "Comment deleted successfully!");
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong please try again later!");
    }
  }
}
