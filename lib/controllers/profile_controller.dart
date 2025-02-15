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
  // * update profile method * //
  Future<void> updateProfile(
      String userId, String description, String name) async {
    try {
      loading.value = true;

      // * Check if image exits then upload it first
      if (image.value != null && image.value!.existsSync()) {
        final String dir = "$userId/profile.jpg";
        final String path =
            await SupabaseService.client.storage.from(Env.s3Bucket).upload(
                  dir,
                  image.value!,
                  fileOptions: const FileOptions(upsert: true),
                );
        await SupabaseService.client.auth.updateUser(
          UserAttributes(
            data: {"image": path},
          ),
        );
      }
      
      // * Update description
      await SupabaseService.client.auth.updateUser(
        UserAttributes(
          data: {
            "description": description,
            "name": name,
          },
        ),
      );
      loading.value = false;
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

  // * Pick the image //
  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) image.value = file;
  }

  //  * Fetch user * //
  void fetchUser(String userId) async {
    try {
      userLoading.value = true;
      final response = await SupabaseService.client
          .from("users")
          .select("*")
          .eq("id", userId)
          .single();
      userLoading.value = false;
      user.value = UserModel.fromJson(response);

      // * Fetch user post nd replies * //
      fetchUserTwinote(userId);
      fetchUser(userId);
    } catch (e) {
      userLoading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

  // * Fetch posts * //
  void fetchUserTwinote(String userId) async {
    try {
      postLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("posts").select('''
    id,content,image,created_at,comment_count,like_count,user_id,
    user:user_id (email , metadata),likes:likes(user_id,post_id)

''').eq("user_id", userId).order("id", ascending: false);
      postLoading.value = false;
      if (response.isNotEmpty) {
        posts.value = [for (var item in response) PostModel.fromJson(item)];
      }
    } catch (e) {
      postLoading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

  // * fetch comments * //
  void fetchReplies(String userId) async {
    try {
      replyLoading.value = true;

      final List<dynamic> response =
          await SupabaseService.client.from("comments").select('''
id,user_id,post_id,reply,created_at,user:user_id (email,metadata)
''').eq("user_id", userId).order("id", ascending: false);
      replyLoading.value = false;
      if (response.isNotEmpty) {
        replies.value = [for (var item in response) ReplyModel.fromJson(item)];
      }
    } catch (e) {
      replyLoading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

  // * Delete twinote * //
  Future<void> deleteTwinote(int postId) async {
    try {
      loading.value = true;
      await SupabaseService.client.from("posts").delete().eq("id", postId);
      loading.value = false;
      posts.removeWhere((element) => element.id == postId);
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      showSnackBar("Success", "Post deleted successfully");
    } catch (e) {
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

 // try delete
  Future<void> deleteComment(int postId) async {
   try {
      loading.value = true;
      // * Decrement comment counter in post table
      await SupabaseService.client.from("comments").delete().eq("id", postId);
      loading.value = false;
      replies.removeWhere((element) => element.id == postId);
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      showSnackBar("Success", "comment deleted successfully!");
    } catch (e) {
      showSnackBar("Error", "Something went wrong please try again later!");
    }
       await SupabaseService.client.rpc("comment_decrement",params: {"count":1,"row_id":postId});
  }
}
