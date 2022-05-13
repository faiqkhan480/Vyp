import 'country_model.dart';
import 'county_model.dart';
import 'district_model.dart';

class SearchModel {
  Country country;
  List<SelectedItems> districts;
  SearchModel({required this.country, required this.districts});
}

class SelectedItems {
  var parent;
  List<dynamic>? children;
  SelectedItems({this.parent, this.children});
}