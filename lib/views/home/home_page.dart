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
          onRefresh: () => controller.fecthTwinote(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black12,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
      width: 40, // Change this to your desired width
      height: 40, // Change this to your desired height
      child: Image.asset(
        "assets/images/mainTag.png",
        fit: BoxFit.fitWidth, // Add this to maintain the aspect ratio
      ),
      )
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(
                    color: Color(0xff242424),
                  ),
                ),
                centerTitle: false,
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => controller.loading.value
                      ? const Loading()
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.posts.length,
                          itemBuilder: (context, index) =>
                              PostCard(post: controller.posts[index]),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
