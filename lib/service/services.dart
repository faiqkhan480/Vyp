import 'package:get/get.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/district.dart';
import 'package:vyv/service/apis.dart';
import 'package:vyv/utils/network.dart';

class Service {
  // ALL COUNTRIES
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

  static search({asd}) async {

  }
}