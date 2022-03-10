import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/countries_controller.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class CountriesScreen extends GetView<CountryController> {
  CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextWidget(
                text: "${Constants.appName}\n",
                color: AppColors.primaryColor,
                size: 10,
                align: TextAlign.center,
                family: 'GemunuLibre',
                shadow: true,
              ),

              if(controller.isLoading())
                Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)),

              if(!controller.isLoading())
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: "Which country to explore?",
                      // color: AppColors.primaryColor,
                      size: 2.4,
                      align: TextAlign.center,
                      // weight: FontWeight.w300,
                      // family: 'GemunuLibre',
                    ),
                    // HorizontalSpace(23),
                    // SvgPicture.asset("assets/images/svgs/arrow_up.svg")
                  ],
                ),

              VerticalSpace(30),

              if(!controller.isLoading() && controller.countries.isNotEmpty)
                SizedBox(
                height: SizeConfig.heightMultiplier * 39,
                child: CupertinoScrollbar(
                  child: ListView(
                    shrinkWrap: true,
                    children: List.generate(controller.countries.length, (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.memory(
                                base64Decode(controller.countries.elementAt(index).imageStr!),
                                height: SizeConfig.heightMultiplier * 3,
                              ),
                            ),
                            TextWidget(
                              text: controller.countries.elementAt(index).countryName,
                              // color: AppColors.primaryColor,
                              size: 2.4,
                              align: TextAlign.center,
                              // family: 'GemunuLibre',
                            ),
                          ],
                        ),
                        subtitle: (controller.countries.elementAt(index > 2 ? (index -1) : index) == controller.countries.last) ? null : Divider(color: AppColors.darkGrey,),
                        onTap: () => handleClick(controller.countries.elementAt(index)),
                      ),
                    )),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  void handleClick(Country country) => controller.setCountry(country);
}
