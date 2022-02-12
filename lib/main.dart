import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyp/screens/countries.dart';
import 'package:vyp/utils/size_config.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return GetMaterialApp(
            title: 'Vyp',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Heebo",
              primarySwatch: Colors.red,
            ),
            home: Countries(),
          );
        },
      ),
    );
  }
}
