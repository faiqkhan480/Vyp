import 'package:get/get.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district.dart';
import 'package:vyv/models/search_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/service/services.dart';

import 'home_controller.dart';

class SearchController extends GetxController {
  // static SearchController get searchController => Get.find();
  static HomeController get homeController => Get.find();

  RxBool fetchingDistrict = false.obs;
  RxBool fetchingCounties = false.obs;
  Rx<Country> selectedCountry = Country().obs;
  List<District> districts = List<District>.empty(growable: true).obs;
  List<County> counties = List<County>.empty(growable: true).obs;
  List<SearchModel> search = List<SearchModel>.empty(growable: true).obs;
  List<SelectedDistrict> selected = List<SelectedDistrict>.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDistricts().then((value) => fetchCounties());
  }
  Future fetchDistricts() async {
    try{
      fetchingDistrict.value = true;
      // var res = await Service.getDistricts(selectedCountry.value.id!);
      var res = await Service.getDistricts(homeController.selectedCountry.value.id!);
      if(res != null) {
        districts.assignAll(res);
        fetchingDistrict.value = false;
        // Get.offNamed(AppRoutes.ROOT);
      }
      else {
        fetchingDistrict.value = false;
      }
    }
    catch (e) {
      print(e);
    }
  }

  Future fetchCounties() async {
    try{
      fetchingCounties.value = true;
      var res = await Service.getCounties(homeController.selectedCountry.value.id!);
      if(res != null) {
        counties.assignAll(res);
        fetchingCounties.value = false;
        setData();
        // Get.offNamed(AppRoutes.ROOT);
      }
      else {
        fetchingCounties.value = false;
      }
    }
    catch (e) {
      print(e);
    }
  }

  void setCountry(Country c) => selectedCountry.value = c;

  void setData() {
    districts.forEach((district) {

      // search.add(SearchModel(
      //   country: selectedCountry.value,
      //   districts: SelectedDistricts(districts: districts, counties: ),
      // ));
    });
  }

  void handleDistrict(bool value, District item, List<County> countyItems) {
    print("fffffff");
    if(value) {
      selected.add(SelectedDistrict(district: item, counties: countyItems));
    }
    else {
      selected.removeWhere((element) => element.district.id == item.id);
    }
  }

  void handleCounty(bool value, District item, County _county) {
    print("called:::: @@@@@");
    List<County> _counties = selected.firstWhere((element) => element.district.id == item.id).counties;
    if(value) {
      _counties.add(_county);
      selected.add(SelectedDistrict(district: item, counties: _counties));
    }
    else {
      print("called:::: ");
      _counties.removeWhere((element) => element.id == _county.id);
      selected.firstWhere((d) => d.district.id == item.id).counties = _counties;
    }
  }
}