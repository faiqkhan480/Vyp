import 'package:get/get.dart';
import 'package:vyv/navigation/bottom_navigation.dart';

// IMPORT BINDINGS
import 'package:vyv/navigation/root_binding.dart';
import 'package:vyv/screens/countries/countries_binding.dart';

// APP VIEWS
import 'package:vyv/screens/countries/countries_screeen.dart';
import 'package:vyv/screens/favorites_screen.dart';
import 'package:vyv/screens/home/home.dart';
import 'package:vyv/screens/home/home_bindings.dart';
import 'package:vyv/screens/info/info_binding.dart';
import 'package:vyv/screens/info/info_screen.dart';

// IMPORT ROUTES NAME
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
        name: AppRoutes.COUNTRIES,
        binding: CountriesBinding(),
        page: () => CountriesScreen()
    ),
    GetPage(
        name: AppRoutes.ROOT,
        binding: RootBinding(),
        page: () => BottomNavigation()
    ),
    GetPage(
        name: AppRoutes.HOME,
        binding: HomeBindings(),
        page: () => HomeScreen()
    ),
    GetPage(
        name: AppRoutes.INFO,
        binding: InfoBinding(),
        page: () => InfoScreen()
    ),
    GetPage(
        name: AppRoutes.FAVORITES,
        page: () => FavoritesScreen()
    ),
  ];
}