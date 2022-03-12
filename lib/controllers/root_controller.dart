import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/models/screen_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/screens/favorites_screen.dart';
import 'package:vyv/screens/home/home.dart';
import 'package:vyv/screens/home/home_bindings.dart';
import 'package:vyv/screens/info/info_binding.dart';
import 'package:vyv/screens/info/info_screen.dart';

/// screens models list
final screensData = <ScreenModel>[
  ScreenModel(name: 'red', colors: Colors.red, navKey: 1),
  ScreenModel(name: 'green', colors: Colors.green, navKey: 2),
  ScreenModel(name: 'blue', colors: Colors.blue, navKey: 3),
];

/// main controller
class RootController extends GetxController {
  static RootController get to => Get.find();

  var currentIndex = 0.obs;
  var currentTab = 0.obs;

  final pages = <String>[AppRoutes.HOME, AppRoutes.HOME, AppRoutes.HOME, AppRoutes.HOME,];

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages.elementAt(index), id: 1);
  }

  void changeTab(int index) {
    currentTab.value = index;
  }

  Route? onGenerateRoute(RouteSettings settings) {
    print("ROUTE : ${settings.name}");
    if(settings.name == AppRoutes.HOME)
    // if(settings.name == "/")
      return GetPageRoute(
        settings: settings,
        binding: HomeBindings(),
        page: () => HomeScreen(),
      );

    if (settings.name == AppRoutes.INFO)
      return GetPageRoute(
        settings: settings,
        binding: InfoBinding(),
        page: () => InfoScreen(),
      );

    if (settings.name == AppRoutes.FAVORITES)
      return GetPageRoute(
        settings: settings,
        page: () => FavoritesScreen()
      );
    return null;
  }
}