import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/components/reset_pass.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/text_component.dart';

import 'dialog_component.dart';

class SettingsSheet extends StatelessWidget {
  final HomeController controller;
  const SettingsSheet({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(vertical: 10),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => ListTile(
              leading: Icon(Icons.language),
              // title: TextWidget(
              //   text: 'change_country',
              //   size: 1.8,
              // ),
              title: DropdownButton<Country>(
                value: controller.countries.firstWhere((element) => element.id == controller.selectedCountry.value.id),
                elevation: 16,
                isExpanded: true,
                onChanged: (Country? value) => controller.setCountry(value!),
                items: List.generate(controller.countries.length, (index) => DropdownMenuItem<Country>(
                  value: controller.countries.elementAt(index),
                  child: Text(controller.countries.elementAt(index).countryName.toString()),
                )),
                // items: _controller.countries.map<DropdownMenuItem>((c) {
                //   return DropdownMenuItem(
                //     value: c,
                //     child: Text(c.countryName ?? ""),
                //   );
                // }).toList(),
              ),
              dense: true,
              onTap: () => null,
            )),
            ListTile(
              leading: Icon(Icons.settings_display),
              title: DropdownButton<String>(
                value: Get.locale!.languageCode,
                elevation: 16,
                isExpanded: true,
                onChanged: (String? value) {
                  var locale = value == "en" ? Locale('en', 'US') : Locale('pt', 'POR');
                  Get.updateLocale(locale);
                },
                items: ["en", "pt"].map<DropdownMenuItem<String>>((lang) {
                  return DropdownMenuItem(
                    value: lang,
                    child: Text(lang == "en" ? "English" : "Portuguese"),
                  );
                }).toList(),
              ),
              // subtitle: Divider(thickness: 1, height: 1,),
              dense: true,
              // contentPadding: EdgeInsets.only(top: 3, bottom: 5),
              onTap: () => null,
            ),

            if(controller.user?.id != null)
              ListTile(
              leading: Icon(Icons.person),
              title: TextWidget(
                text: 'reset_password',
                size: 1.8,
              ),
              // subtitle: Divider(thickness: 1, height: 1,),
              dense: true,
              // contentPadding: EdgeInsets.only(top: 3, bottom: 5),
              onTap: handleClick,
            ),
          ],
        )
    );
  }

  handleClick() {
    Get.back(closeOverlays: true);
    Get.dialog(DialogComponent(isReset: true,), barrierDismissible: true, useSafeArea: true);
  }
}
