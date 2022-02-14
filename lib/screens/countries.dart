import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyp/controllers/countries_controller.dart';
import 'package:vyp/models/country_model.dart';
import 'package:vyp/utils/app_colors.dart';
import 'package:vyp/utils/constants.dart';
import 'package:vyp/widgets/text_component.dart';

class CountriesScreen extends StatelessWidget {
  CountriesScreen({Key? key}) : super(key: key);

  CountryController controller = Get.put(CountryController());

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

              for(Country country in controller.countries)
                ListTile(
                  title: TextWidget(
                    text: country.countryName,
                    // color: AppColors.primaryColor,
                    size: 3,
                    align: TextAlign.center,
                    // family: 'GemunuLibre',
                  ),
                  subtitle: Divider(),
                  onTap: () => handleClick(country),
                ),
            ],
          )
      ),
    );
  }

  void handleClick(Country country) {
    // controller.fetchCountryData(country);
    Get.offNamed('/home');
  }
}
