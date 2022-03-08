import 'country_model.dart';
import 'county_model.dart';
import 'district_model.dart';

class SearchModel {
  Country country;
  List<SelectedDistrict> districts;
  SearchModel({required this.country, required this.districts});
}

class SelectedDistrict {
  District? district;
  List<County>? counties;
  SelectedDistrict({this.district, this.counties});
}