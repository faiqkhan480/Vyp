// IMPORTING PACKAGES USED IN THIS COMPONENT
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/navigation/bot_navigation.dart';

// IMPORTING APP VIEWS/SCREENS FOR ROUTES
import 'navigation/bottom_navigation.dart';
import 'screens/countries.dart';
import 'screens/favorites_screen.dart';
import 'screens/home.dart';
import 'screens/info_screen.dart';

// IMPORTING APP UTILS USED IN THIS COMPONENT
import 'utils/app_translation.dart';
import 'utils/size_config.dart';


void main() async {
  await GetStorage.init();
  // final translationProvider = TranslationProvider();

  // final translations = await translationProvider.getTranslations();
  // runApp(MyApp(translations: translations!,));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppTranslations? translations;

  const MyApp({Key? key, this.translations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation); // SET APP CONSTRAINTS
          return GetMaterialApp(
            title: 'Vyv',
            translations: AppTranslations(),
            locale: AppTranslations.locale,
            fallbackLocale: AppTranslations.fallbackLocale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Heebo",
              primarySwatch: Colors.red,
            ),
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => CountriesScreen()),
              GetPage(name: '/navigator', page: () => BottomNavigation()),
              GetPage(name: '/home', page: () => HomeScreen()),
              GetPage(name: '/info', page: () => InfoScreen()),
              GetPage(name: '/fav', page: () => FavoritesScreen()),
            ],
            // home: Countries(),
          );
        },
      ),
    );
  }
}
