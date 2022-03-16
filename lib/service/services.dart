import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/models/sub_category_model.dart';
import 'package:vyv/models/user_model.dart';

import 'package:vyv/service/apis.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/network.dart';

// IMPORT MODEL CLASSES
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';

class AppService {
  static GetStorage _box = GetStorage();

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

  // GET ALL SUB CATEGORIES
  static getSubCategories() async {
    try{
      var res = await Network.get(url: Api.subCategories);
      if(res != null)
        return subCategoryFromMap(res);
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

  // SEARCH SPOTS
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

  // SPOT DETAIL
  static spotDetail({int? spotId}) async {
    try{
      var res = await Network.get(url: Api.spotDetail + spotId.toString());
      if(res != null)
        return Spot.fromMap(jsonDecode(res));
      return null;
    } catch(e){
      print("ERROR SPOT DETAIL: $e");
      Get.rawSnackbar(title: "Error in spot detail request!");
      return throw Exception(e);
    }
  }

  // REGISTER USER
  static formSubmit({String? email, String? password, body}) async {
    try{
      var res = (body != null) ?
      await Network.post(url: Api.register + password!, payload: body):
      await Network.get(url: Api.login + email! + "&" + password! );
      if(res != null) {
        var user = json.decode(res);
        if(user['statusCode'] == 200) {
          _box.write('user', jsonEncode(user['result']));
          return userFromMap(jsonEncode(user['result']));
        }
        Get.rawSnackbar(message: user['message'].toString(), backgroundColor: AppColors.danger);
      }
      return null;
    } catch(e){
      print("ERROR LOGIN: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  // CREATE FAVORITE FOLDER
  static createFolder({String? name, num? userId}) async {
    try{
      var res = await Network.post(url: "${Api.createFolder}$name/$userId");
      if(res != null) {
        var user = json.decode(res);
        return user['message'].toString();
        // Get.rawSnackbar(message: user['message'].toString(), backgroundColor: AppColors.danger);
      }
      return null;
    } catch(e){
      print("ERROR LOGIN: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }


}