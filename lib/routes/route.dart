import 'package:get/get.dart';

import '../views/auth/login.dart';
import '../views/auth/register.dart';
import '../views/home.dart';
import '../views/notification/notifications.dart';
import '../views/profile/edit_profile.dart';
import '../views/profile/profile.dart';
import '../views/replies/add_reply.dart';
import '../views/replies/show_profile.dart';
import '../views/setting/about.dart';
import '../views/setting/account.dart';
import '../views/setting/centre.dart';
import '../views/setting/help.dart';
import '../views/setting/privacy_policy.dart';
import '../views/setting/setting.dart';
import '../views/setting/terms.dart';
import '../views/shareTogether/add_twinote.dart';
import '../views/shareTogether/show_image.dart';
import '../views/shareTogether/show_twinote.dart';
import 'route_names.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteNames.home, page: () => Home()),
    GetPage(
        name: RouteNames.login,
        page: () => const Login(),
        transition: Transition.fade),
    GetPage(
        name: RouteNames.register,
        page: () => const Register(),
        transition: Transition.fadeIn),
    GetPage(
        name: RouteNames.setting,
        page: () => const Setting(),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: RouteNames.addreply,
        page: () => const AddReply(),
        transition: Transition.downToUp),
    GetPage(
        name: RouteNames.addtwinote,
        page: () => AddTwinote(),
        transition: Transition.fadeIn),
    GetPage(
        name: RouteNames.profile,
        page: () => const Profile(),
        transition: Transition.fadeIn),
    GetPage(
        name: RouteNames.notification,
        page: () => const Notifications(),
        transition: Transition.fadeIn),
    GetPage(
        name: RouteNames.editprofile,
        page: () => const EditProfile(),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: RouteNames.showprofile,
        page: () => const ShowProfile(),
        transition: Transition.cupertino),
    GetPage(
        name: RouteNames.showtwinote,
        page: () => const ShowTwinote(),
        transition: Transition.fadeIn),
    GetPage(
        name: RouteNames.showimage,
        page: () => ShowImage(),
        transition: Transition.fade),
    GetPage(
        name: RouteNames.about,
        page: () => const About(),
        transition: Transition.leftToRight),
    GetPage(
        name: RouteNames.privacy,
        page: () => const Privacy(),
        transition: Transition.leftToRight),
    GetPage(
        name: RouteNames.terms,
        page: () => const Terms(),
        transition: Transition.leftToRight),
    GetPage(
        name: RouteNames.account,
        page: () => Account(),
        transition: Transition.leftToRight),
    GetPage(
        name: RouteNames.help,
        page: () => const Help(),
        transition: Transition.leftToRight),
    GetPage(
        name: RouteNames.centre,
        page: () => Centre(),
        transition: Transition.leftToRight),
    
  ];
}
