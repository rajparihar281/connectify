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
id,post_id,notification,created_at,user_id
''').eq("to_user_id", userId).order("id", ascending: false);
      if (response.isNotEmpty) {
        final userIds = response.map((n) => n['user_id']).toSet().toList();
        final List<dynamic> users = await SupabaseService.client
            .from('users')
            .select('id,email,metadata')
            .inFilter('id', userIds);
        final userMap = {for (var u in users) u['id']: u};
        notifications.value = [
          for (var item in response)
            NotificationModel.fromJson(
                {...item, 'user': userMap[item['user_id']]})
        ];
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!...please try again later");
    }
  }
}
