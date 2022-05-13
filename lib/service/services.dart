import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/models/folder_model.dart';
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
      _box.write("countries", res);
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

  // COUNTRY TAB
  static getCountryData(Map<String, dynamic> payload) async {
    try{
      var res = await Network.get(url: Api.countryTab, params: payload.map((key, value) => MapEntry(key, value.toString())));
      if(res != null)
        return spotFromMap(res);
      return null;
    } catch(e){
      print("ERROR COUNTRY: $e");
      Get.rawSnackbar(message: "Error in country tab request!");
      return throw Exception(e);
    }
  }

  // DISTRICT TAB
  static getDistrictData({Map<String, dynamic>? payload}) async {
    try{
      var res = await Network.get(url: Api.districtTab, params: payload);
      if(res != null)
        return spotFromMap(res);
      return null;
    } catch(e){
      print("ERROR DISTRICT: $e");
      Get.rawSnackbar(message: "Error in district tab request!");
      return throw Exception(e);
    }
  }

  // COUNTY TAB
  static getCountyData({Map<String, dynamic>? payload}) async {
    try{
      var res = await Network.get(url: Api.countyTab, params: payload);
      if(res != null)
        return spotFromMap(res);
      return null;
    } catch(e){
      print("ERROR COUNTY: $e");
      Get.rawSnackbar(message: "Error in county tab request!");
      return throw Exception(e);
    }
  }

  static districtItems(int districtId, Map<String, dynamic> payload) async {
    try{
      var res = await Network.get(url: "${Api.district}$districtId", params: payload.map((key, value) => MapEntry(key, value.toString())));
      if(res != null)
        return spotFromMap(res);
      return null;
    } catch(e){
      print("ERROR DISTRICT: $e");
      Get.rawSnackbar(message: "Error in district request!");
      return throw Exception(e);
    }
  }

  static countyItems(int countyId, Map<String, dynamic> payload) async {
    try{
      var res = await Network.get(url: "${Api.county}$countyId", params: payload.map((key, value) => MapEntry(key, value.toString())));
      if(res != null)
        return spotFromMap(res);
      return null;
    } catch(e){
      print("ERROR DISTRICT: $e");
      Get.rawSnackbar(message: "Error in district request!");
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
          if(body == null)
            _box.write('user', jsonEncode(user['result']));
          return userFromMap(jsonEncode(user['result']));
        }
        Get.rawSnackbar(message: user['message'].toString(), backgroundColor: AppColors.danger);
      }
      else {
        Get.rawSnackbar(title: "Unable to register", message: "Please contact app admin", backgroundColor: AppColors.danger);
        return null;
      }
    } catch(e){
      print("ERROR LOGIN: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  static resetPass({num? userId, Map<String, dynamic>? payload}) async {
    try{
      var res = await Network.put(url: "${Api.resetPass}$userId", params: payload!.map((key, value) => MapEntry(key, value.toString())));
      if(res != null) {
        var user = json.decode(res);
        if(user['statusCode'] == 200)
          return user['message'].toString();
        Get.rawSnackbar(message: user['message'].toString(), backgroundColor: AppColors.danger);
        return null;
      }
      else {
        Get.rawSnackbar(title: "Unable to reset password", message: "Please contact app admin", backgroundColor: AppColors.danger);
        return null;
      }
    } catch(e){
      print("ERROR RESET: $e");
      Get.rawSnackbar(message: "Error in reset pass request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  // ADD TO FAVORITE
  static addFavorite({required num? idSpot, required num? idFolder, required num? idUser, required String? favoriteName, required String? imageStr}) async {
    print(idFolder);
    try{
      // var res = await Network.post(url: "${Api.addFavorite}$idSpot/$idFolder/$idUser/$favoriteName/${imageStr!.isEmpty ? " " : imageStr}");
      var res = await Network.post(url: "${Api.addFavorite}$idSpot/$idFolder");
      print(res);
      if(res != null) {
        var _folder = json.decode(res);
        if(_folder['statusCode'] == 200) {
          // Get.rawSnackbar(message: _folder['message'].toString(), backgroundColor: AppColors.danger);
          // return Folder.fromMap(_folder['result']);
          return _folder['message'];
        }
        else if(_folder['message'] != null)
          Get.rawSnackbar(message: _folder['message'].toString(), backgroundColor: AppColors.danger);
      }
      return null;
    } catch(e){
      print("ERROR ADD FAV: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  // CREATE FAVORITE FOLDER
  static createFolder({String? name, num? userId}) async {
    try{
      var res = await Network.post(url: "${Api.createFolder}$name/$userId");
      print(res);
      if(res != null) {
        var _folder = json.decode(res);
        if(_folder['statusCode'] == 200) {
          Get.rawSnackbar(message: _folder['message'].toString(), backgroundColor: AppColors.success);
          return Folder.fromMap(_folder['result']);
        }
        else if(_folder['message'] != null)
          Get.rawSnackbar(message: _folder['message'].toString(), backgroundColor: AppColors.danger);
      }
      return null;
    } catch(e){
      print("ERROR LOGIN: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  static deleteFavorite({num? favId, num? folderId}) async {
    try{
      var res = await Network.delete(url: "${Api.delFavorite}$favId/folder/$folderId");
      if(res != null) {
        var _folder = json.decode(res);
        if(_folder['statusCode'] == 200) {
          // Get.rawSnackbar(message: _folder['message'].toString(), backgroundColor: AppColors.danger);
          return _folder['message'].toString();
        }
        else if(_folder['message'] != null)
          Get.rawSnackbar(message: _folder['message'].toString(), backgroundColor: AppColors.danger);
      }
      return null;
    } catch(e){
      print("ERROR LOGIN: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  // GET FAVORITE FOLDER
  static getFolders(num? userId) async {
    try{
      var res = await Network.get(url: "${Api.folderList}$userId");
      print(res);
      if(res != null)
        return folderFromMap(res);
      return null;
    } catch(e){
      print("ERROR LOGIN: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  // GET ALL FAVORITES
  static getALLFavorites(num userId) async {
    try{
      var res = await Network.get(url: "${Api.allFavorites}$userId");
      if(res != null)
        return favoriteFromMap(res);
      return null;
    } catch(e){
      print("ERROR LOGIN: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  // GET FAVORITES
  static getFavorites({num? folderId}) async {
    try{
      var res = await Network.get(url: "${Api.folder}$folderId");
      if(res != null)
        return favoriteFromMap(res);
      return null;
    } catch(e){
      print("ERROR LOGIN: $e");
      Get.rawSnackbar(message: "Error in login request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }

  static getAllNationality() async {
    try{
      var res = await Network.get(url: Api.nationality);
      // print(res);
      if(res != null)
        return jsonDecode(res);
      return null;
    } catch(e){
      print("ERROR NATIONALITY: $e");
      Get.rawSnackbar(message: "Error in nationality request!", backgroundColor: AppColors.danger);
      return throw Exception(e);
    }
  }
}