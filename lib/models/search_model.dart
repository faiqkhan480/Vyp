import 'country_model.dart';
import 'county_model.dart';
import 'district.dart';

class SearchModel {
  Country country;
  List<SelectedDistricts> districts;
  SearchModel({required this.country, required this.districts});
}

class SelectedDistricts {
  District district;
  List<County> counties;
  SelectedDistricts({required this.district, required this.counties});
}