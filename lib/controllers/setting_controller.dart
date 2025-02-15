import 'package:get/get.dart';

import '../routes/route_names.dart';
import '../services/storage_service.dart';
import '../services/supabase_service.dart';
import '../utils/storage_keys.dart';

class SettingController extends GetxController {
  void logout() async {
    // * Remove user session from local storage //
    StorageService.session.remove(StorageKeys.userSession);
    await SupabaseService.client.auth.signOut();
    Get.offAllNamed(RouteNames.login);
  }
}
  