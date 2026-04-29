import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/loading.dart';
import '../../widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () => controller.fecthPost(),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: Colors.black12,
                title: Text(
                  "CONNECTIFY",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(
                    color: Color(0xff242424),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(() {
                  if (controller.loading.value) return const Loading();
                  if (controller.hasError.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Text(
                            'Failed to load posts.\nPull down to retry.',
                            textAlign: TextAlign.center),
                      ),
                    );
                  }
                  if (controller.posts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Text('No posts yet.',
                            style: TextStyle(fontSize: 16)),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) =>
                        PostCard(post: controller.posts[index]),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
