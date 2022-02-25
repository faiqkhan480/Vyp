import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/countries_controller.dart';
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

              if(controller.isLoading.value)
                Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)),

              if(!controller.isLoading.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: "Which country to explore?",
                      // color: AppColors.primaryColor,
                      size: 3,
                      align: TextAlign.center,
                      // weight: FontWeight.w300,
                      // family: 'GemunuLibre',
                    ),
                    HorizontalSpace(23),
                    SvgPicture.asset("assets/images/svgs/arrow_up.svg")
                  ],
                ),

              VerticalSpace(30),

              for(Country country in controller.countries)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            country.id == 1 ?
                            "https://media.istockphoto.com/vectors/national-flag-of-portugal-country-vector-id669426148?k=20&m=669426148&s=612x612&w=0&h=neBRclYZ1-h1ESFqHjBp6eIapsquyMsfaLI0XC7eNDU=" :
                            country.id == 2 ?
                            "https://stuffedeyes.files.wordpress.com/2018/06/spain-2906824_960_720.png?w=748":
                            "https://cdn.britannica.com/29/22529-004-ED1907BE/Union-Flag-Cross-St-Andrew-of-George.jpg",
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                        ),
                        TextWidget(
                          text: country.countryName,
                          // color: AppColors.primaryColor,
                          size: 3,
                          align: TextAlign.center,
                          // family: 'GemunuLibre',
                        ),
                      ],
                    ),
                    subtitle: (country == controller.countries.last) ? null : Divider(color: AppColors.darkGrey,),
                    onTap: () => handleClick(country),
                  ),
                ),
            ],
          )
      ),
    );
  }

  void handleClick(Country country) {
    // controller.fetchCountryData(country);
    Get.offNamed(AppRoutes.ROOT);
  }
}
