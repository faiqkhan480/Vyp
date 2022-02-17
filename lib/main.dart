import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyp/navigation/bottom_navigation.dart';

// IMPORTING APP VIEWS/SCREENS ROUTES
import 'screens/countries.dart';
import 'screens/home.dart';
import 'screens/info_screen.dart';

// IMPORTING APP UTILS
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
          SizeConfig().init(constraints, orientation);
          return GetMaterialApp(
            title: 'Vyp',
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
              GetPage(name: '/navigator', page: () => BottomNavigator()),
              GetPage(name: '/home', page: () => HomeScreen()),
              GetPage(name: '/info', page: () => InfoScreen()),
            ],
            // home: Countries(),
          );
        },
      ),
    );
  }
}
