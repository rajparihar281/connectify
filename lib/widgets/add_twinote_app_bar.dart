import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/twinote_controller.dart';
import '../services/navigation_service.dart';
import '../services/supabase_service.dart';
class AddTwinoteAppBar extends StatelessWidget {
  AddTwinoteAppBar({super.key});
  final TwinoteController controller = Get.find<TwinoteController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff242424))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.find<NavigationService>().backToPrevPage();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "New Post",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Obx(() =>
           TextButton(
              onPressed: ()
               {
                if (controller.content.value.isNotEmpty) {
                  controller.store(Get.find<SupabaseService>().currentUser.value!.id);

                }
              }
              ,
              child: controller.loading.value
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : const Text("Post",
                      style: TextStyle(
                          fontSize: 15,
                         fontWeight: FontWeight.bold,
          )))),
        ],
      ),
    );
  }
}
