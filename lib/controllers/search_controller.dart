import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/search_model.dart';
import 'package:vyv/models/sub_category_model.dart';
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
  // MAIN DATA VARIABLES
  List<District> districts = List<District>.empty(growable: true).obs;
  List<County> counties = List<County>.empty(growable: true).obs;
  List<Category> categories = List<Category>.empty(growable: true).obs;
  List<SubCategory> subCategories = List<SubCategory>.empty(growable: true).obs;

  List<SearchModel> search = List<SearchModel>.empty(growable: true).obs;
  RxList<SelectedDistrict> selectedDistricts = List<SelectedDistrict>.empty().obs;
  RxList<SelectedDistrict> selectedCategories = List<SelectedDistrict>.empty().obs;
  RxList selectedItems = List.empty(growable: true).obs;
  List<District> selectedParents = List<District>.empty(growable: true).obs;
  List<Category> categoryParents = List<Category>.empty(growable: true).obs;
  List<County> selectedChildren = List<County>.empty(growable: true).obs;
  List<SubCategory> categoryChildren = List<SubCategory>.empty(growable: true).obs;

  // DUPLICATE VARIABLE FOR USE IN SEARCHING
  List<District> searchDistricts = List<District>.empty(growable: true).obs;
  List<County> searchCounties = List<County>.empty(growable: true).obs;
  List<Category> searchCategories = List<Category>.empty(growable: true).obs;
  List<SubCategory> searchSubCategories = List<SubCategory>.empty(growable: true).obs;

  TextEditingController countrySearch = TextEditingController();
  TextEditingController categorySearch = TextEditingController();

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
        searchDistricts.assignAll(res);
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
        searchCounties.assignAll(res);
        fetchingCounties.value = false;
        setData();
        // Get.offNamed(AppRoutes.ROOT);
      }
      else {
        fetchingCounties.value = false;
      }
      // Get.find<HomeController>().handleSearch();
      Get.find<HomeController>().fetchCountry();
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
        searchCategories.assignAll(res);
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
        searchSubCategories.assignAll(res);
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

  void handleByCountry(val) {
    if(!val) {
      districts.forEach((District _parent) {
        selectedDistricts.add(SelectedDistrict(parent: _parent, children: counties.where((element) => element.districtId == _parent.id).toList()));
        selectedParents.add(_parent);
        selectedChildren.assignAll(counties.where((element) => element.districtId == _parent.id).toList());
      });
      selectedItems.assignAll(districts);
    }
    else {
      selectedDistricts.clear();
      selectedItems.clear();
      selectedParents.clear();
      selectedChildren.clear();
    }
  }

  void handleAllCategorySelection(val) {
    if(!val) {
      categories.forEach((Category _parent) {
        selectedCategories.add(SelectedDistrict(parent: _parent, children: subCategories.where((element) => element.categoryId == _parent.id).toList()));
        // selectedItems.add(_parent);
        categoryParents.add(_parent);
        categoryChildren.assignAll(subCategories.where((element) => element.categoryId == _parent.id).toList());
      });
      selectedItems.assignAll(categories);
    }
    else {
      selectedCategories.clear();
      selectedItems.clear();
      categoryParents.clear();
      categoryChildren.clear();
    }
  }

  void handleByDistrict(bool value, dynamic parentItem, List<dynamic> childItems, isCategory) {
    if(value) {
      selectedDistricts.add(SelectedDistrict(parent: parentItem, children: childItems));
      selectedItems.add(parentItem);
      selectedParents.add(parentItem);
      selectedChildren.assignAll(childItems as List<County>);
    }
    else {
      selectedDistricts.removeWhere((element) => element.parent!.id == parentItem.id);
      selectedItems.remove(parentItem);
      selectedParents.remove(parentItem);
      selectedItems.removeWhere((element) => element.districtId == parentItem.id);
      selectedChildren.removeWhere((element) => element.districtId == parentItem.id);
    }
  }

  void handleAllCountySelection(bool value, dynamic item, isCategory) {
    if(value) {
      selectedDistricts.removeWhere((element) => element.parent!.id == item.id);
      selectedItems.removeWhere((element) =>
      element.runtimeType == District || element.runtimeType == Category ?
      element.id == item.id :
      (isCategory ? element.categoryId : element.districtId) == item.id);
      selectedDistricts.add(SelectedDistrict(
          parent: item,
          children: isCategory ? subCategories.where((c) => c.categoryId == item.id).toList() : counties.where((c) => c.districtId == item.id).toList()
      ));
      // selectedItems.add(item);
      selectedItems.assignAll(isCategory ? subCategories.where((c) => c.categoryId == item.id).toList() : counties.where((c) => c.districtId == item.id).toList());
    }
    else
    {
      selectedDistricts.removeWhere((element) => element.parent!.id == item.id);
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
      bool _checkDistrict = selectedDistricts.any((element) => element.parent!.id == parent.id);
      // IF NOT DISTRICT IS SELECTED THAN SELECT ALL
      if(!_checkDistrict) {
        selectedDistricts.add(SelectedDistrict(
            parent: isCategory ? categories.firstWhere((cat) => cat.id == parent.id) : districts.firstWhere((d) => d.id == parent.id),
            children: isCategory ? subCategories.where((subCat) => subCat.id == child.id).toList() : counties.where((c) => c.id == child.id).toList()
        ));
        selectedDistricts.refresh();
        selectedParents.add(parent);
      }
      // IF DISTRICT IS SELECTED THAN ADD ONE COUNTY ITEM
      else {
        List<dynamic>? _children = selectedDistricts.firstWhereOrNull((element) => element.parent!.id == parent.id)?.children;
        _children!.add(child);
        // selected.firstWhereOrNull((element) => element.district!.id == item.id)!.counties!.assignAll(_counties);
        selectedDistricts.firstWhereOrNull((element) => element.parent!.id == parent.id)!.children = _children;
        // selected.firstWhere((element) => element.district!.id == item.id).counties!.add(_county);
        selectedDistricts.refresh();
      }
      if(!selectedItems.contains(parent) && selectedParents.any((element) => element.id != parent.id))
        selectedParents.add(parent);
      //   selectedItems.add(parent);
      selectedItems.add(child);
      selectedChildren.add(child);
    }
    // IF UNCHECK ITEM
    else {
      List<dynamic>? _children = selectedDistricts.firstWhereOrNull((element) => element.parent!.id == parent.id)?.children;
      _children!.removeWhere((element) => element.id == child.id);
      selectedDistricts.firstWhere((d) => d.parent!.id == parent.id).children = _children;
      selectedDistricts.refresh();
      selectedItems.remove(child);
      selectedChildren.remove(child);
      if(selectedItems.isEmpty || !selectedItems.any((element) => element.districtId == parent.id)) {
        selectedParents.remove(parent);
        selectedDistricts.clear();
      }
    }
  }

  void removeSearchItems(item, isCategory) {
    if(item.runtimeType == District || item.runtimeType == Category){
      selectedDistricts.removeWhere((element) => element.parent!.id == item.id);
      selectedParents.removeWhere((element) => element.id == item.id);
    }
    else {
      List<dynamic>? _children = selectedDistricts.firstWhereOrNull((element) => element.parent!.id == (isCategory ? item.categoryId : item.districtId))?.children;
      _children!.removeWhere((element) => element.id == item.id);
      selectedDistricts.firstWhere((d) => d.parent!.id == (isCategory ? item.categoryId : item.districtId)).children = _children;
      selectedDistricts.refresh();
      selectedChildren.removeWhere((element) => element.id == item.id);
    }
    selectedItems.remove(item);
    if(selectedItems.isEmpty){
      selectedDistricts.clear();
    }
  }

  void handleByCategory(bool value, Category parentItem, List<SubCategory> childItems) {
    if(value) {
      selectedCategories.add(SelectedDistrict(parent: parentItem, children: childItems));
      selectedItems.add(parentItem);
      categoryParents.add(parentItem);
      categoryChildren.assignAll(childItems);
    }
    else {
      selectedCategories.removeWhere((element) => element.parent!.id == parentItem.id);
      selectedItems.remove(parentItem);
      categoryParents.remove(parentItem);
      selectedItems.removeWhere((element) => element.categoryId == parentItem.id);
      categoryChildren.removeWhere((element) => element.categoryId == parentItem.id);
    }
  }

  void handleBySubCategory(bool value, Category parent, SubCategory child) {
    // IF CHECK ITEM
    if(value) {
      bool _checkDistrict = selectedCategories.any((element) => element.parent!.id == parent.id);
      // IF NOT DISTRICT IS SELECTED THAN SELECT ALL
      if(!_checkDistrict) {
        selectedCategories.add(SelectedDistrict(
            parent: categories.firstWhere((cat) => cat.id == parent.id),
            children: subCategories.where((subCat) => subCat.id == child.id).toList()
        ));
        selectedCategories.refresh();
        categoryParents.add(parent);
      }
      // IF DISTRICT IS SELECTED THAN ADD ONE COUNTY ITEM
      else {
        List<dynamic>? _children = selectedCategories.firstWhereOrNull((element) => element.parent!.id == parent.id)?.children;
        _children!.add(child);
        selectedCategories.firstWhereOrNull((element) => element.parent!.id == parent.id)!.children = _children;
        selectedCategories.refresh();
      }
      if(!selectedItems.contains(parent) && categoryParents.any((element) => element.id != parent.id))
        categoryParents.add(parent);
      //   selectedItems.add(parent);
      selectedItems.add(child);
      categoryChildren.add(child);
    }
    // IF UNCHECK ITEM
    else {
      List<dynamic>? _children = selectedCategories.firstWhereOrNull((element) => element.parent!.id == parent.id)?.children;
      _children!.removeWhere((element) => element.id == child.id);
      selectedCategories.firstWhere((d) => d.parent!.id == parent.id).children = _children;
      selectedCategories.refresh();
      selectedItems.remove(child);
      categoryChildren.remove(child);
      if(selectedItems.isEmpty || !selectedItems.any((element) => element.districtId == parent.id)) {
        categoryParents.remove(parent);
        selectedCategories.clear();
      }
    }
  }

  void handleAllSubCategorySelection(bool value, dynamic item) {
    if(value) {
      selectedCategories.removeWhere((element) => element.parent!.id == item.id);
      selectedItems.removeWhere((element) =>
      element.runtimeType == Category ?
      element.id == item.id :
      element.categoryId == item.id);
      selectedCategories.add(SelectedDistrict(
          parent: item,
          children: subCategories.where((c) => c.categoryId == item.id).toList()
      ));
      selectedItems.assignAll(subCategories.where((c) => c.categoryId == item.id).toList());
    }
    else
    {
      selectedCategories.removeWhere((element) => element.parent!.id == item.id);
      selectedItems.removeWhere((element) =>
      element.runtimeType == Category ?
      element.id == item.id :
      element.categoryId == item.id);
    }
  }

  void handleSearchChange(String val, bool _isCategory) {
    if(val.isNotEmpty) {
      if (_isCategory) {
        searchCategories.assignAll(searchCategories.where((element) => element.name!.contains(val)).toList());
      }
      else {
        searchDistricts.assignAll(searchDistricts.where((element) => element.name!.contains(val)).toList());
      }
    }
    else {
      if (_isCategory) {
        searchCategories.assignAll(categories);
      }
      else {
        searchDistricts.assignAll(districts);
      }
    }
    update();
    // searchDistricts.refresh();
  }
}