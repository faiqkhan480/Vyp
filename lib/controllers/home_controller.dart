import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/models/user_model.dart';
import 'package:vyv/service/services.dart';

class HomeController extends GetxController {
  // static HomeController get to => Get.find();
  Rx<Country> selectedCountry = Country().obs;
  // static SearchController get searchController => Get.find();
  RxBool showMap = false.obs;
  RxBool loading = true.obs;
  final _lastPage = false.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 10.obs;
  GetStorage box = GetStorage();
  RxList<Spot> spots = List<Spot>.empty(growable: true).obs;
  Rx<User> _user = User().obs;

  User? get user => _user.value;
  int get limit => pageSize.value;
  int get _page => pageNum.value;
  bool get lastPage => _lastPage.value;

  set user(User? value) {
    _user.value = value!;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(box.read("user") != null)
      user = userFromMap(box.read("user"));
    if(box.read("country") != null)
      selectedCountry.value = Country.fromMap(box.read("country"));
    // ever(pageNum, (_) => handleSearch());
  }

  setValue(User _val) {
    print("Lll::::>, ${_val.id}");
    _user.value = _val;
    print("val::::>, ${_user.value.id}");
  }

  void changeView() {
    print("CALLED::::::");
    showMap.value = !showMap.value;
  }

  void setCountry(Country c) {
    selectedCountry.value = c;
    // Get.offNamed(AppRoutes.ROOT);
  }

  void handleSearch({List? extraParams, pageKey}) async {
    // Get.back();
    try{
      loading.value = true;
      Map<String, dynamic> _params = {
        "PageNumber": pageKey ?? _page,
        "PageSize": limit
      };
      if(extraParams != null) {
        for (int i = 0; i < extraParams.length; i++) {
          if(extraParams.elementAt(i).runtimeType == County)
            _params['countyId[$i]'] = json.encode(extraParams.elementAt(i).id);
          else if(extraParams.elementAt(i).runtimeType == Category)
            _params['categoryId[$i]'] = json.encode(extraParams.elementAt(i).id);
          else if(extraParams.elementAt(i).runtimeType == District)
            _params['districtId[$i]'] = json.encode(extraParams.elementAt(i).id);
        }
      }
      var res = await AppService.searchSpot(payload: _params);
      if(res != null) {
        if (res.isEmpty) {
          _lastPage.value = true;
        }
        if(spots.isEmpty) spots.assignAll(res);
        else spots.addAll(res);
        if(res.isNotEmpty)
          pageNum.value += 1;
        loading.value = false;
      }
      else {
        loading.value = false;
      }
    }
    catch (e) {
      print(e);
    }
    finally {
      loading.value = false;
    }
  }

  void _changePaginationFilter(int page, int limit) {
    // pageNum.value = page;
    // pageSize.value = limit;
    // _paginationFilter.update((val) {
    //   val.page = page;
    //   val.limit = limit;
    // });
  }

  void handleLogout() {
    box.remove("user");
    _user.close();
    user = User();
    Get.back(closeOverlays: true);
  }

  void loadNextPage() => _changePaginationFilter(_page + 1, limit);
}