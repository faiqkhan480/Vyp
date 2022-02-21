import 'package:vyv/models/country_model.dart';
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
}