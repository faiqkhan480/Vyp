import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyp/models/country_model.dart';
import 'package:vyp/service/services.dart';

class CountryController extends GetxController {
  Rx<bool> isLoading = false.obs;
  List<Country> countries = List<Country>.empty(growable: true).obs;
  Rx<Country?> selectedCountry = Country().obs;

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  fetchCountries() async {
    try{
      isLoading(true);
      List<Country>? res = await Service.getCountries();
      if(res != null)
        countries.assignAll(res);
      isLoading(false);
    } catch(e) {
      isLoading(false);
      Get.rawSnackbar(message: "$e", backgroundColor: Colors.red);
    }
  }

  fetchCountryData(Country country) async {
    try{
      isLoading(true);
      List<Country>? res = await Service.getCountries();
      if(res != null)
        countries.assignAll(res);
      isLoading(false);
    } catch(e) {
      isLoading(false);
      Get.rawSnackbar(message: "$e", backgroundColor: Colors.red);
    }
  }
}