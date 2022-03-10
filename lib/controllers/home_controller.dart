import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
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

  set setUser(User value) {
    _user.value = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(box.read("user") != null)
      setUser = userFromMap(box.read("user"));
    if(box.read("country") != null)
      selectedCountry.value = Country.fromMap(box.read("country"));
    // ever(pageNum, (_) => handleSearch());
  }

  changeView() {
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
      Map<String, dynamic> params = {
        // "categoryId": categoryIds,
        // "districtId": districtIds,
        // "countyId": countyIds,
        "PageNumber": pageKey ?? _page,
        "PageSize": limit
      };
      // List b = [];
      // if(extraParams != null) {
      //   extraParams.forEach((p) {
      //     print(p.toMap());
      //     // params.addIf(p.runtimeType == County, "countyId", p.id);
      //     b.add(p.id);
      //     // if(p.runtimeType == County)
      //     //   params.addAll({"countyId": p.id});
      //     //
      //     // else
      //     //   params.addAll({"districtId": p.id});
      //   });
      //   var c = b.map((e) => MapEntry("districtId", e));
      //   print(c);
      //   // params.addEntries(b.map((e) => MapEntry("districtId", e)));
      //   // params.addAll(c as MapEntry);
      //   print(params);
      // }
      //   params.addAll(reqIds);
      var res = await AppService.searchSpot(payload: params);
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

  void loadNextPage() => _changePaginationFilter(_page + 1, limit);
}