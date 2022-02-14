import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyp/screens/countries.dart';
import 'package:vyp/screens/home.dart';
import 'package:vyp/utils/size_config.dart';
import 'package:vyp/utils/app_translation.dart';
import 'package:vyp/utils/translations_provider.dart';


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
              GetPage(name: '/home', page: () => HomeScreen()),
            ],
            // home: Countries(),
          );
        },
      ),
    );
  }
}
