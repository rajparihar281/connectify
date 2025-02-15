import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/navigation_service.dart';


class Home extends StatelessWidget {
  Home({super.key});
  final NavigationService navigationService = Get.put(NavigationService());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationService.currentIndex.value,
            onDestinationSelected: (value) =>
                navigationService.updateIndex(value),
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: "Home",
                selectedIcon: Icon(Icons.home),
              ),
               NavigationDestination(
                icon: Icon(Icons.search_outlined),
                label: "Search",
                selectedIcon: Icon(Icons.search),
              ),
              NavigationDestination(
                icon: Icon(Icons.add_outlined),
                label: "Add Twinote",
                selectedIcon: Icon(Icons.add),
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline_outlined),
                label: "Profile",
                selectedIcon: Icon(Icons.favorite_outlined),
              ),
              NavigationDestination(
                icon: Icon(Icons.person_2_outlined),
                label: "Profile",
                selectedIcon: Icon(Icons.person_2),
              )
            ],
          ),
          body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.ease,
              switchOutCurve: Curves.easeInOut,
              child: navigationService
                  .pages()[navigationService.currentIndex.value]),
        )
        );
  }
}
