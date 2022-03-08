import 'package:get/get.dart';
import 'package:vyv/models/spot_model.dart';

import 'package:vyv/service/apis.dart';
import 'package:vyv/utils/network.dart';

// IMPORT MODEL CLASSES
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';

class AppService {
  // GET ALL COUNTRIES
  static getCountries() async {
    try{
      var res = await Network.get(url: Api.countries);
      if(res != null)
        return countryFromMap(res);
      return null;
    } catch(e){
      print(e);
      return throw Exception(e);
    }
  }

  // GET ALL CATEGORIES
  static getCategories() async {
    try{
      var res = await Network.get(url: Api.categories);
      if(res != null)
        return categoryFromMap(res);
      return null;
    } catch(e){
      print(e);
      return throw Exception(e);
    }
  }

  // ALL COUNTRY DISTRICTS
  static getDistricts(int countryId) async {
    try{
      var res = await Network.get(url: Api.districts + countryId.toString());
      if(res != null)
        return districtFromMap(res);
      return null;
    } catch(e){
      print("ERROR DISTRICT: $e");
      Get.rawSnackbar(title: "Error district in Request");
      return throw Exception(e);
    }
  }

  // ALL COUNTRY COUNTIES
  static getCounties(int countryId) async {
    try{
      var res = await Network.get(url: Api.counties + countryId.toString());
      if(res != null)
        return countyFromMap(res);
      return null;
    } catch(e){
      print("ERROR COUNTY: $e");
      Get.rawSnackbar(title: "Error in county request!");
      return throw Exception(e);
    }
  }

  static searchSpot({Map<String, dynamic>? payload}) async {
    try{
      var res = await Network.get(url: Api.spot, params: payload!.map((key, value) => MapEntry(key, value.toString())));
      if(res != null)
        return spotFromMap(res);
      return null;
    } catch(e){
      print("ERROR SPOT: $e");
      Get.rawSnackbar(title: "Error in spot request!");
      return throw Exception(e);
    }
  }
}