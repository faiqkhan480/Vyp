import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/models/screen_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/screens/favorites_screen.dart';
import 'package:vyv/screens/home/home.dart';
import 'package:vyv/screens/home/home_bindings.dart';
import 'package:vyv/screens/info_screen.dart';

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
    // if(settings.name == "/" || settings.name == AppRoutes.HOME)
    if(settings.name == "/")
      return GetPageRoute(
        settings: settings,
        binding: HomeBindings(),
        page: () => HomeScreen(),
      );

    if (settings.name == AppRoutes.INFO)
      return GetPageRoute(
        settings: settings,
        page: () => InfoScreen(),
      );

    if (settings.name == AppRoutes.FAVORITES)
      return GetPageRoute(
        settings: settings,
        page: () => FavoritesScreen()
      );
    // return GetPageRoute(
    //   settings: settings,
    //   binding: HomeBindings(),
    //   page: () => HomeScreen(),
    // );
  }

  // final navMenuIndex = 0.obs;
  //
  // ScreenModel get currentScreenModel => screensData[navMenuIndex()];
  // Color get navMenuItemColor => currentScreenModel.colors!;
  //
  // // store the pages stack.
  // List<Widget>? _pages;
  //
  // // get navigators.
  // List<Widget> get menuPages => _pages ??= screensData.map((e) => _TabNav(e)).toList();
  //
  // // widget stuffs.
  // List<BottomNavigationBarItem> get navMenuItems => screensData
  //     .map((e) =>
  //     BottomNavigationBarItem(icon: Icon(Icons.widgets), label: e.name))
  //     .toList();

  // void openDetails(int shade) {
  //   final model = currentScreenModel;
  //   Get.to(
  //     PageColorDetails(
  //       title: model.name,
  //       color: model.colors,
  //       shade: shade,
  //     ),
  //     transition: Transition.fade,
  //     id: model.navKey,
  //   );
  // }
}

// class _TabNav extends GetView<RootController> {
//   final ScreenModel model;
//   _TabNav(this.model);
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: Get.nestedKey(model.navKey),
//       onGenerateRoute: (settings) =>
//           MaterialPageRoute(builder: (_) => PageColorList(model: model)),
//     );
//   }
// }