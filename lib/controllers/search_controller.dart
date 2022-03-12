import 'package:get/get.dart';
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/search_model.dart';
import 'package:vyv/models/sub_category_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/service/services.dart';

import 'home_controller.dart';

class SearchController extends GetxController {
  // static SearchController get searchController => Get.find();
  static HomeController get homeController => Get.find();

  RxBool fetchingDistrict = false.obs;
  RxBool fetchingCounties = false.obs;
  RxBool fetchingCategories = false.obs;
  RxBool fetchingSubCategories = false.obs;
  RxBool check = false.obs;
  Rx<Country> selectedCountry = Country().obs;
  List<District> districts = List<District>.empty(growable: true).obs;
  List<County> counties = List<County>.empty(growable: true).obs;
  List<Category> categories = List<Category>.empty(growable: true).obs;
  List<SubCategory> subCategories = List<SubCategory>.empty(growable: true).obs;
  List<SearchModel> search = List<SearchModel>.empty(growable: true).obs;
  RxList<SelectedDistrict> selected = List<SelectedDistrict>.empty().obs;
  RxList selectedItems = List.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDistricts().then((value) => fetchCounties());
    fetchCategories().then((value) => fetchSubCategories());
  }

  Future fetchDistricts() async {
    try{
      fetchingDistrict.value = true;
      // var res = await Service.getDistricts(selectedCountry.value.id!);
      var res = await AppService.getDistricts(homeController.selectedCountry.value.id!);
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
      Get.find<HomeController>().handleSearch();
    }
    catch (e) {
      print(e);
    }
  }

  Future fetchCategories() async {
    try{
      fetchingCategories.value = true;
      var res = await AppService.getCategories();
      if(res != null) {
        categories.assignAll(res);
        fetchingCategories.value = false;
        setData();
        // Get.offNamed(AppRoutes.ROOT);
      }
      else {
        fetchingCategories.value = false;
      }
      // Get.find<HomeController>().handleSearch();
    }
    catch (e) {
      print(e);
    }
  }

  Future fetchSubCategories() async {
    try{
      fetchingSubCategories.value = true;
      var res = await AppService.getSubCategories();
      if(res != null) {
        subCategories.assignAll(res);
        fetchingSubCategories.value = false;
        setData();
        // Get.offNamed(AppRoutes.ROOT);
      }
      else {
        fetchingSubCategories.value = false;
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

  void handleByCountry(isCategory) {
    if(selected.isEmpty) {
      (isCategory ? categories : districts).forEach((dynamic d) {
        selected.add(
            SelectedDistrict(
                parent: d,
                children: isCategory ? subCategories.where((sub) => sub.id == d.id).toList() : counties.where((c) => c.districtId == d.id).toList()
            )
        );
      });
    }
    else {
      selected.clear();
    }
  }

  void handleByDistrict(bool value, dynamic parentItem, List<dynamic> childItems, isCategory) {
    if(value) {
      selected.add(SelectedDistrict(parent: parentItem, children: childItems));
      selectedItems.add(parentItem);
    }
    else {
      selected.removeWhere((element) => element.parent!.id == parentItem.id);
      selectedItems.remove(parentItem);
    }
  }

  handleAllCountySelection(bool value, dynamic item, isCategory) {
    if(value) {
      selected.removeWhere((element) => element.parent!.id == item.id);
      selectedItems.removeWhere((element) =>
      element.runtimeType == District || element.runtimeType == Category ?
      element.id == item.id :
      (isCategory ? element.categoryId : element.districtId) == item.id);
      selected.add(SelectedDistrict(
          parent: item,
          children: isCategory ? subCategories.where((c) => c.categoryId == item.id).toList() : counties.where((c) => c.districtId == item.id).toList()
      ));
      // selectedItems.add(item);
      selectedItems.assignAll(isCategory ? subCategories.where((c) => c.categoryId == item.id).toList() : counties.where((c) => c.districtId == item.id).toList());
    }
    else
    {
      selected.removeWhere((element) => element.parent!.id == item.id);
      selectedItems.removeWhere((element) =>
      element.runtimeType == District || element.runtimeType == Category ?
      element.id == item.id :
      (isCategory ? element.categoryId : element.districtId) == item.id);
      // selectedItems.remove(item);
    }
  }

  void handleByCounty(bool value, dynamic parent, dynamic child, bool isCategory) {
    // IF CHECK ITEM
    if(value) {
      bool _checkDistrict = selected.any((element) => element.parent!.id == parent.id);
      // IF NOT DISTRICT IS SELECTED THAN SELECT ALL
      if(!_checkDistrict) {
        selected.add(SelectedDistrict(
            parent: isCategory ? categories.firstWhere((cat) => cat.id == parent.id) : districts.firstWhere((d) => d.id == parent.id),
            children: isCategory ? subCategories.where((subCat) => subCat.id == child.id).toList() : counties.where((c) => c.id == child.id).toList()
        ));
        selected.refresh();
      }
      // IF DISTRICT IS SELECTED THAN ADD ONE COUNTY ITEM
      else {
        List<dynamic>? _children = selected.firstWhereOrNull((element) => element.parent!.id == parent.id)?.children;
        _children!.add(child);
        // selected.firstWhereOrNull((element) => element.district!.id == item.id)!.counties!.assignAll(_counties);
        selected.firstWhereOrNull((element) => element.parent!.id == parent.id)!.children = _children;
        // selected.firstWhere((element) => element.district!.id == item.id).counties!.add(_county);
        selected.refresh();
      }
      selectedItems.add(child);
    }
    // IF UNCHECK ITEM
    else {
      List<dynamic>? _children = selected.firstWhereOrNull((element) => element.parent!.id == parent.id)?.children;
      _children!.removeWhere((element) => element.id == child.id);
      selected.firstWhere((d) => d.parent!.id == parent.id).children = _children;
      selected.refresh();
      selectedItems.removeWhere((element) => element.id == parent.id);
      selectedItems.remove(child);
    }
  }

  void removeSearchItems(item, isCategory) {
    if(item.runtimeType == District || item.runtimeType == Category){
      selected.removeWhere((element) => element.parent!.id == item.id);
    }
    else {
      List<dynamic>? _children = selected.firstWhereOrNull((element) => element.parent!.id == (isCategory ? item.categoryId : item.districtId))?.children;
      _children!.removeWhere((element) => element.id == item.id);
      selected.firstWhere((d) => d.parent!.id == (isCategory ? item.categoryId : item.districtId)).children = _children;
      selected.refresh();
    }
    selectedItems.remove(item);
  }
}