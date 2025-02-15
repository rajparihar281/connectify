import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../services/supabase_service.dart';
import '../utils/helper.dart';

class ReplyController extends GetxController {
  var loading = false.obs;
  final TextEditingController replycontroller = TextEditingController(text: "");
  var reply = "".obs;

  void addReply(String userId, int postId, String postUserId) async {
    try {
      loading.value = true;
      // * increase the post comment count * //
      await SupabaseService.client
          .rpc("comment_increment", params: {"count": 1, "row_id": postId});

      // * Add comment notification * //
      await SupabaseService.client.from("notifications").insert({
        "user_id": userId,
        "notification": "Commented on your post",
        "to_user_id": postUserId,
        "post_id": postId
      });

      // * Add comment in table * //
      await SupabaseService.client.from("comments").insert({
        "post_id": postId,
        "user_id": userId,
        "reply": replycontroller.text,
      });
      loading.value = false;
      showSnackBar("Success", "Comment Posted");
    } catch (error) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }

  @override
  void onClose() {
    replycontroller.dispose();
    super.onClose();
  }
}
