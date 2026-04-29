import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../services/supabase_service.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  var hasError = false.obs;
  RxList<PostModel> posts = RxList<PostModel>();
  RealtimeChannel? _channel;

  @override
  void onInit() {
    super.onInit();
    fecthPost().then((_) => listenChanges());
  }

  Future<void> fecthPost() async {
    try {
      loading.value = true;
      hasError.value = false;
      final List<dynamic> response =
          await SupabaseService.client.from("posts").select('''
    id,content,image,created_at,comment_count,like_count,user_id,
    likes:likes(user_id,post_id)
''').order("id", ascending: false);
      final enriched = await _enrichWithUsers(response);
      loading.value = false;
      posts.value = enriched;
    } catch (e) {
      loading.value = false;
      hasError.value = true;
      debugPrint('fetchPost error: $e');
    }
  }

  Future<List<PostModel>> _enrichWithUsers(List<dynamic> response) async {
    if (response.isEmpty) return [];
    final userIds = response.map((p) => p['user_id']).toSet().toList();
    final List<dynamic> users = await SupabaseService.client
        .from('users')
        .select('id,email,metadata')
        .inFilter('id', userIds);
    final userMap = {for (var u in users) u['id']: u};
    return [
      for (var item in response)
        PostModel.fromJson({...item, 'user': userMap[item['user_id']]})
    ];
  }

  void listenChanges() {
    _channel = SupabaseService.client
        .channel('public:posts')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'posts',
            callback: (payload) {
              final PostModel post = PostModel.fromJson(payload.newRecord);
              updateFeed(post);
            })
        .subscribe();
  }

  void updateFeed(PostModel post) async {
    try {
      final user = await SupabaseService.client
          .from('users')
          .select('id,email,metadata')
          .eq('id', post.userId as Object)
          .single();
      post.likes = [];
      post.user = UserModel.fromJson(user);
      posts.insert(0, post);
    } catch (e) {
      debugPrint('updateFeed error: $e');
    }
  }

  @override
  void onClose() {
    _channel?.unsubscribe();
    super.onClose();
  }
}
