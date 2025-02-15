import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/notification_controller.dart';
import '../../routes/route_names.dart';
import '../../services/supabase_service.dart';
import '../../utils/helper.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/loading.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController controller = Get.put(NotificationController());
  @override
  void initState() {
    controller
        .fetchNotifications(Get.find<SupabaseService>().currentUser.value!.id);
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
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Notification"),
      ),
      body: SingleChildScrollView(
        child: Obx(() => controller.loading.value
            ? const Loading()
            : Column(
                children: [
                  if (controller.notifications.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.notifications.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () => {
                          Get.toNamed(RouteNames.showtwinote,
                              arguments: controller.notifications[index].postId)
                        },
                        leading: CircleImage(
                            url: controller
                                .notifications[index].user?.metadata?.image),
                        title: Text(controller
                            .notifications[index].user!.metadata!.name!),
                        trailing: Text(formateDateFromNow(
                            controller.notifications[index].createdAt!)),
                        subtitle:
                            Text(controller.notifications[index].notification!),
                      ),
                    )
                  else
                    const SizedBox(
                      width: 10000,
                      child: Text(
                        "No notification found",
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              )),
      ),
    );
  }
}
