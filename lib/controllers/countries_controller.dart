import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/service/services.dart';

class CountryController extends GetxController {
  static CountryController get controller => Get.find();

  Rx<bool> isLoading = false.obs;
  List<Country> countries = List<Country>.empty(growable: true).obs;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  void setCountry(Country c) {
    box.write('country', c.toMap());
    Get.offNamed(AppRoutes.HOME);
  }

  fetchCountries() async {
    try{
      isLoading(true);
      List<Country>? res = await AppService.getCountries();
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
      List<Country>? res = await AppService.getCountries();
      if(res != null)
        countries.assignAll(res);
      isLoading(false);
    } catch(e) {
      isLoading(false);
      Get.rawSnackbar(message: "$e", backgroundColor: Colors.red);
    }
  }
}