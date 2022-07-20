import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/components/dialog_component.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/models/screen_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/screens/account_screen.dart';
import 'package:vyv/screens/favorites/favorite_binding.dart';
import 'package:vyv/screens/favorites/favorites_screen.dart';
import 'package:vyv/screens/favorites/folder_screen.dart';
import 'package:vyv/screens/home/home.dart';
import 'package:vyv/screens/home/home_bindings.dart';
import 'package:vyv/screens/info/info_binding.dart';
import 'package:vyv/screens/info/info_screen.dart';
import 'package:vyv/screens/map_screen.dart';
import 'package:vyv/screens/plans/plan_screen.dart';
import 'package:vyv/screens/reviews_screen.dart';

import '../screens/calender/calender_screen.dart';
import 'home_controller.dart';

/// screens models list
final screensData = <ScreenModel>[
  ScreenModel(name: 'red', colors: Colors.red, navKey: 1),
  ScreenModel(name: 'green', colors: Colors.green, navKey: 2),
  ScreenModel(name: 'blue', colors: Colors.blue, navKey: 3),
];

/// main controller
class RootController extends GetxController {
  // static HomeController get to => Get.find<Home>();

  var currentIndex = 0.obs;
  var currentTab = 0.obs;

  final pages = <String>[AppRoutes.HOME, AppRoutes.HOME, AppRoutes.HOME, AppRoutes.HOME,];

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages.elementAt(index), id: 1);
  }

  void changeTab(int index) {
    if(index > 0 && Get.find<HomeController>().user?.id != null) {
      Get.dialog(DialogComponent(), barrierDismissible: true, useSafeArea: true);
    } else {
      currentTab.value = index;
    }
  }

  Route? homeRoutes(RouteSettings settings) {
    switch(settings.name) {
      case "/" :
          return GetPageRoute(
            settings: settings,
            binding: HomeBindings(),
            page: () => HomeScreen(),
          );
      break;
      case AppRoutes.INFO:
        return GetPageRoute(
          settings: settings,
          binding: InfoBinding(),
          page: () => InfoScreen(spot: settings.arguments as Spot),
        );
        break;
      case AppRoutes.FAVORITES:
        return GetPageRoute(
            settings: settings,
            binding: FavoriteBinding(),
            page: () => FavoritesScreen()
        );
        break;
      case AppRoutes.FOLDER:
        return GetPageRoute(
            settings: settings,
            page: () => settings.arguments.runtimeType == Folder ? FolderScreen(folder: settings.arguments as Folder) : FolderScreen(favorites: settings.arguments as List<Favorite>)
        );
        break;
      case AppRoutes.ACCOUNT :
        return GetPageRoute(
            settings: settings,
            page: () => AccountScreen()
        );
        break;
      case AppRoutes.MAP:
        return GetPageRoute(
            settings: settings,
            page: () => MapScreen(spot: settings.arguments as Spot)
        );
        break;
      case AppRoutes.REVIEWS:
        return GetPageRoute(
            settings: settings,
            page: () => ReviewsScreen()
        );
        break;
    }
    return null;
  }

  Route? calenderRoutes(RouteSettings settings) {
    // if(settings.name == AppRoutes.HOME)
    if(settings.name == "/")
      return
        GetPageRoute(
            page: () => CalenderScreen()
        );

    if(settings.name == AppRoutes.PLAN)
      return GetPageRoute(
          settings: settings,
          // binding: FavoriteBinding(),
          page: () => PlanScreen()
      );
    return null;
  }
}