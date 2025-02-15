import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/twinote_controller.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/loading.dart';
import '../../widgets/post_card.dart';
import '../../widgets/reply_card.dart';
import '../profile/profile.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({super.key});

  @override
  State<ShowProfile> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowProfile> {
  final String userId = Get.arguments;
  final ProfileController controller = Get.put(ProfileController());
  final TwinoteController tcontroller = Get.put(TwinoteController());
  final TextEditingController nameEditingController =
      TextEditingController(text: "");
  @override
  void initState() {
    controller.fetchUser(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset("assets/images/profileTag.png")),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 100,
                collapsedHeight: 100,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // if(controller.userLoading.isFalse)
                                Text(
                                  controller.user.value.metadata?.name ?? "",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: context.width * 0.50,
                                  child: Text(controller
                                          .user.value.metadata?.description ??
                                      ""),
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => CircleImage(
                              url: controller.user.value.metadata?.image,
                              radius: 40,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    const TabBar(indicatorSize: TabBarIndicatorSize.tab, tabs: [
                      Tab(text: "Posts"),
                      Tab(text: "Comments"),
                    ]),
                  ))
            ];
          },
          body: TabBarView(
            children: [
              Obx(() => SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        if (controller.replyLoading.value)
                          const Loading()
                        else if (controller.posts.isNotEmpty)
                          ListView.builder(
                            itemCount: controller.posts.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                PostCard(post: controller.posts[index]),
                          )
                        else
                          const Center(
                            child: Text("No Post found"),
                          )
                      ],
                    ),
                  )),
              Obx(() => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        if (controller.replyLoading.value)
                          const Loading()
                        else if (controller.replies.isNotEmpty)
                          ListView.builder(
                            itemCount: controller.replies.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                ReplyCard(reply: controller.replies[index]),
                          )
                        else
                          const Center(
                            child: Text("No comment found"),
                          )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
