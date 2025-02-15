import 'package:get/get.dart';
import '../models/notification_model.dart';
import '../services/supabase_service.dart';
import '../utils/helper.dart';

class NotificationController extends GetxController {
  var loading = false.obs;
  RxList<NotificationModel> notifications = RxList<NotificationModel>();
  void fetchNotifications(String userId) async {
    try {
      loading.value = true;

      final List<dynamic> response =
          await SupabaseService.client.from("notifications").select('''
id,post_id,notification,created_at,user_id,user:user_id (email,metadata)
''').eq("to_user_id", userId).order("id", ascending: false);
      loading.value = false;
      if (response.isNotEmpty) {
        notifications.value = [
          for (var item in response) NotificationModel.fromJson(item)
        ];
      }
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }
}
