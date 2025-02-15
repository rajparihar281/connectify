import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/env.dart';

class SupabaseService extends GetxService {
  Rx<User?> currentUser = Rx<User?>(null);
  @override
  void onInit() async {
    await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseKey);
    currentUser.value = client.auth.currentUser;
    listenAuthChanges();
    super.onInit();
  }

  static final SupabaseClient client = Supabase.instance.client;

  // * Listen auth changes * //
  void listenAuthChanges() {
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.userUpdated) {
        currentUser.value = data.session?.user;
      } else if (event == AuthChangeEvent.signedIn) {
        currentUser.value = data.session?.user;
      }
    });
  }
}
