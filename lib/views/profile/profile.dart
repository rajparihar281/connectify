import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/notification_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../routes/route_names.dart';
import '../../services/supabase_service.dart';
import '../../utils/styles/button_stye.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/loading.dart';
import '../../widgets/post_card.dart';
import '../../widgets/reply_card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController controller = Get.put(ProfileController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final NotificationController notificationController =
      Get.put(NotificationController());
  @override
  void initState() {
    if (supabaseService.currentUser.value?.id != null) {
      controller.fetchUserTwinote(supabaseService.currentUser.value!.id);
      controller.fetchReplies(supabaseService.currentUser.value!.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Color(0xff242424),
            )),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(RouteNames.setting),
              icon: const Icon(Icons.settings)),
        ],
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 23,
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 160,
                collapsedHeight: 160,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                supabaseService
                                    .currentUser.value!.userMetadata?["name"],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: context.width * 0.50,
                                child: Text(supabaseService.currentUser.value
                                        ?.userMetadata?["description"] ??
                                    "Your Description"),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => CircleImage(
                            url: supabaseService
                                .currentUser.value?.userMetadata?["image"],
                            radius: 40,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () =>
                                Get.toNamed(RouteNames.editprofile),
                            style: customOutLineStyle(),
                            child: const Text("Edit profile"),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => {},
                            style: customOutLineStyle(),
                            child: const Text("Share profile"),
                          ),
                        ),
                      ],
                    )
                  ]),
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
                            itemBuilder: (context, index) => PostCard(
                              post: controller.posts[index],
                              isAuthCard: true,
                              callBack: controller.deleteTwinote,
                            ),
                          )
                        else
                          const Center(
                            child: Text("No post found"),
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
                            itemBuilder: (context, index) => ReplyCard(
                              reply: controller.replies[index],
                              isAuthCard: true,
                              callback: controller.deleteComment,
                            ),
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


class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  SliverAppBarDelegate(this._tabBar);

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
