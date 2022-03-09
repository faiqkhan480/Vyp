import 'package:get/get.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/search_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/service/services.dart';

import 'home_controller.dart';

class SearchController extends GetxController {
  // static SearchController get searchController => Get.find();
  static HomeController get homeController => Get.find();

  RxBool fetchingDistrict = false.obs;
  RxBool fetchingCounties = false.obs;
  RxBool check = false.obs;
  Rx<Country> selectedCountry = Country().obs;
  List<District> districts = List<District>.empty(growable: true).obs;
  List<County> counties = List<County>.empty(growable: true).obs;
  List<SearchModel> search = List<SearchModel>.empty(growable: true).obs;
  RxList<SelectedDistrict> selected = List<SelectedDistrict>.empty().obs;
  RxList selectedItems = List.empty(growable: true).obs;

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
      var res = await AppService.getDistricts(homeController.selectedCountry.value.id!);
      if(res != null) {
        districts.assignAll(res);
        fetchingDistrict.value = false;
        Get.find<HomeController>().handleSearch();
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
      var res = await AppService.getCounties(homeController.selectedCountry.value.id!);
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

  void handleByCountry() {
    if(selected.isEmpty) {
      districts.forEach((d) {
        selected.add(
            SelectedDistrict(
                district: d,
                counties: counties.where((c) => c.districtId == d.id).toList()
            )
        );
      });
    }
    else {
      selected.clear();
    }
  }

  void handleByDistrict(bool value, District item, List<County> countyItems) {
    if(value) {
      selected.add(SelectedDistrict(district: item, counties: countyItems));
      selectedItems.add(item);
    }
    else {
      selected.removeWhere((element) => element.district!.id == item.id);
      selectedItems.remove(item);
    }
  }

  handleAllCountySelection(bool value, District item) {
    if(value) {
      selected.removeWhere((element) => element.district!.id == item.id);
      selectedItems.removeWhere((element) => element.runtimeType == District ? element.id == item.id : element.districtId == item.id);
      selected.add(SelectedDistrict(
          district: item,
          counties: counties.where((c) => c.districtId == item.id).toList()
      ));
      // selectedItems.add(item);
      selectedItems.assignAll(counties.where((c) => c.districtId == item.id).toList());
    }
    else
    {
      selected.removeWhere((element) => element.district!.id == item.id);
      selectedItems.removeWhere((element) => element.runtimeType == District ? element.id == item.id : element.districtId == item.id);
      // selectedItems.remove(item);
    }
  }

  void handleByCounty(bool value, District item, County _county) {
    // IF CHECK ITEM
    if(value) {
      bool _checkDistrict = selected.any((element) => element.district!.id == item.id);
      // IF NOT DISTRICT IS SELECTED THAN SELECT ALL
      if(!_checkDistrict) {
        selected.add(SelectedDistrict(
            district: districts.firstWhere((d) => d.id == item.id),
            counties: counties.where((c) => c.id == _county.id).toList()
        ));
        selected.refresh();
      }
      // IF DISTRICT IS SELECTED THAN ADD ONE COUNTY ITEM
      else {
        List<County>? _counties = selected.firstWhereOrNull((element) => element.district!.id == item.id)?.counties;
        _counties!.add(_county);
        // selected.firstWhereOrNull((element) => element.district!.id == item.id)!.counties!.assignAll(_counties);
        selected.firstWhereOrNull((element) => element.district!.id == item.id)!.counties = _counties;
        // selected.firstWhere((element) => element.district!.id == item.id).counties!.add(_county);
        selected.refresh();
      }
      selectedItems.add(_county);
    }
    // IF UNCHECK ITEM
    else {
      List<County>? _counties = selected.firstWhereOrNull((element) => element.district!.id == item.id)?.counties;
      _counties!.removeWhere((element) => element.id == _county.id);
      selected.firstWhere((d) => d.district!.id == item.id).counties = _counties;
      selected.refresh();
      selectedItems.removeWhere((element) => element.id == item.id);
      selectedItems.remove(_county);
    }
  }

  void removeSearchItems(item) {
    if(item.runtimeType == District){
      selected.removeWhere((element) => element.district!.id == item.id);
    }
    else {
      List<County>? _counties = selected.firstWhereOrNull((element) => element.district!.id == item.districtId)?.counties;
      _counties!.removeWhere((element) => element.id == item.id);
      selected.firstWhere((d) => d.district!.id == item.districtId).counties = _counties;
      selected.refresh();
    }
    selectedItems.remove(item);
  }
}