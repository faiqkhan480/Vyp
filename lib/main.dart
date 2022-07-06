// IMPORTING PACKAGES USED IN THIS COMPONENT
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vyv/routes/app_pages.dart';
import 'package:vyv/routes/app_routes.dart';

// IMPORTING APP UTILS USED IN THIS COMPONENT
import 'controllers/home_controller.dart';
import 'utils/app_translation.dart';
import 'utils/size_config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
            title: 'IViv',
            translations: AppTranslations(),
            locale: AppTranslations.locale,
            fallbackLocale: AppTranslations.fallbackLocale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Heebo",
              primarySwatch: Colors.red,
            ),
            // initialBinding: InitialBinding(),
            initialRoute: AppRoutes.ROOT,
            getPages: AppPages.list,
            // home: Countries(),
          );
        },
      ),
    );
  }
}

class InitialBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}