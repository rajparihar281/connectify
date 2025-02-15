import '../views/notification/notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../views/home/home_page.dart';
import '../views/profile/profile.dart';
import '../views/search/search.dart';
import '../views/shareTogether/add_twinote.dart';


class NavigationService extends GetxService {
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;

  // all pages //
  List<Widget> pages() {
    return [
      const HomePage(),
      const Search(),
      AddTwinote(),
      const Notifications(),
      const Profile(),
    ];
  }

  // update index //
  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

  // * back to previous page * //
  void backToPrevPage() {
    currentIndex.value = previousIndex.value;
  }
}
