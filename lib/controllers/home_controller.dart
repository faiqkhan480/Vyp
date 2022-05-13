import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/models/sub_category_model.dart';
import 'package:vyv/models/user_model.dart';
import 'package:vyv/service/services.dart';
import 'package:vyv/utils/app_colors.dart';

class HomeController extends GetxController {
  // static HomeController get to => Get.find();
  Rx<Country> selectedCountry = Country().obs;
  List<Country> countries = List<Country>.empty(growable: true).obs;
  // static SearchController get searchController => Get.find();
  RxBool showMap = false.obs;
  RxBool loading = true.obs;
  final _lastPage = false.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 10.obs;
  GetStorage box = GetStorage();
  RxList<Spot> spots = List<Spot>.empty(growable: true).obs;
  RxList<Spot> districts = List<Spot>.empty(growable: true).obs;
  RxList<Spot> counties = List<Spot>.empty(growable: true).obs;
  Rx<User> _user = User().obs;
  RxList<Folder> _folders = List<Folder>.empty(growable: true).obs;
  int _currentTab = 0;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  List<Placemark> placeMarks = List<Placemark>.empty().obs;
  Map<String, dynamic> _countryParams = {};
  Map<String, dynamic> _districtParams = {};
  Map<String, dynamic> _countyParams = {};

  List<Folder> get folders => _folders;
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
    _determinePosition();
    if(box.read("user") != null)
      setUser();
    if(box.read("country") != null)
      selectedCountry.value = Country.fromMap(box.read("country"));
    if(box.read("countries") != null)
    countries.assignAll(countryFromMap(box.read("countries")));
  }

  // GET CURRENT LOCATION
  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position _position = await Geolocator.getCurrentPosition();
    lat.value = _position.latitude;
    long.value = _position.longitude;
    List<Placemark> _placeMarks = await placemarkFromCoordinates(_position.latitude, _position.longitude);
    placeMarks.assignAll(_placeMarks);
  }

  setValue(User _val) => _user.value = _val;

  void changeView() async {
    // print("CALLED::::::");
    showMap.value = !showMap.value;
    // _determinePosition();
  }

  void changeTab(tab) {
    print("TAB::::::$tab");
    if(_currentTab == tab)
      return;
    else if(tab == 0) {
      fetchCountry(page: 1);
    }
    else if(tab == 1) {
      fetchDistricts();
    }
    else if(tab == 2) {
      fetchCounty();
    }
    _currentTab = tab;
  }

  void setUser() async {
    user = userFromMap(box.read("user"));
    if(box.read("folders") == null) {
      try{
        loading.value = true;
        var res = await AppService.getFolders(user!.id);
        if(res != null ) {
          box.write("folders", folderToMap(res));
          folders.assignAll(res);
        }
        loading.value = false;
      }
      catch (e) {
        print("error: $e");
      }
      finally {
        loading.value = false;
      }
    }
  }

  void setCountry(Country c) async {
    box.write('country', c.toMap());
    selectedCountry.value = c;
    await Get.find<SearchController>().fetchDistricts();
    await Get.find<SearchController>().fetchCounties();
    // Get.offNamed(AppRoutes.ROOT);
  }

  void handleLocation() async {
    PermissionStatus _permission = await Permission.location.status;
    if(_permission == PermissionStatus.granted) {
      await openAppSettings();
    } else {
      _determinePosition();
    }
  }

  void handleSearch({List? extraParams, pageKey, bool? isCategory}) async {
    // Get.back();
    print(extraParams?.length);
    try{
      _districtParams = {};
      _countyParams = {};
      _countryParams = {"PageNumber": 1,};
      if(extraParams != null) {
        for (int i = 0; i < extraParams.length; i++) {
          if(isCategory == true) {
            if(extraParams.elementAt(i).runtimeType == Category){
              _districtParams['categoriesId[${_districtParams.length}]'] = json.encode(extraParams.elementAt(i).id);
              _countryParams['categoriesId[${_countyParams.length}]'] = json.encode(extraParams.elementAt(i).id);
            }
            if(extraParams.elementAt(i).runtimeType == SubCategory){
              _districtParams['subCategoriesId[${_districtParams.length}]'] = json.encode(extraParams.elementAt(i).id);
              _countryParams['subCategoriesId[${_countyParams.length}]'] = json.encode(extraParams.elementAt(i).id);
            }
          }
          else {
            if(extraParams.elementAt(i).runtimeType == County)
              _countyParams['countiesId[${_countyParams.length}]'] = json.encode(extraParams.elementAt(i).id);
            if(extraParams.elementAt(i).runtimeType == District)
              _districtParams['districtsId[${_districtParams.length}]'] = json.encode(extraParams.elementAt(i).id);
          }
        }
      }
      if(_currentTab == 0)
        fetchCountry(page: 1);
      else if(_currentTab == 1)
        fetchDistricts();
      else if(_currentTab == 2)
        fetchCounty();
      Get.back();
    }
    catch (e) {
      print(e);
    }
    finally {
      // loading.value = false;
    }
  }

  Future loadMore({int? id, pageKey}) async {
    // Get.back();
    try{
      loading.value = true;
      if(_currentTab == 0) {
        Map<String, dynamic> _params = {"PageNumber": pageKey ?? _page};
        await fetchCountry();
      }
      else if(_currentTab == 1) {
        Map<String, dynamic> _params = {"pageNumber": pageKey};
        var res = await AppService.districtItems(id!, _params);
        if(res != null) {
          if (res.isEmpty)
            _lastPage.value = true;
          if (spots.isEmpty)
            spots.assignAll(res);
          else
            spots.addAll(res);
          if (res.isNotEmpty)
            return pageKey;
          loading.value = false;
        }
      }
      else if(_currentTab == 2) {
        Map<String, dynamic> _params = {"pageNumber": pageKey};
        var res = await AppService.countyItems(id!, _params);
        if(res != null) {
          if (res.isEmpty)
            _lastPage.value = true;
          if (spots.isEmpty)
            spots.assignAll(res);
          else
            spots.addAll(res);
          if (res.isNotEmpty)
            return pageKey;
          loading.value = false;
        }
      }
    }
    catch (e) {
      print(e);
    }
    finally {
      loading.value = false;
    }
  }

  // FETCH COUNTRY TAB DATA
  Future fetchCountry({int? page}) async {
    try{
      Map<String, dynamic> _params = {
        "PageNumber": page ?? _page,
      };
     if(page != null) {
       spots.clear();
       pageNum.value = 1;
     }
      loading.value = true;
     _params.addAll(_districtParams);
     var res = await AppService.getCountryData(_params);
      if(res != null) {
        if (res.isEmpty)
          _lastPage.value = true;
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

  // FETCH DISTRICT TAB DATA
  void fetchDistricts() async {
    try{
      spots.clear();
      loading.value = true;
      var res = await AppService.getDistrictData(payload: _districtParams);
      if(res != null) {
        if(spots.isEmpty) spots.assignAll(res);
        else spots.addAll(res);
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

  // FETCH COUNTY TAB DATA
  void fetchCounty() async {
    try{
      spots.clear();
      loading.value = true;
      var res = await AppService.getCountyData(payload: _countyParams);
      if(res != null) {
        if(spots.isEmpty) spots.assignAll(res);
        else spots.addAll(res);
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

  Future<Spot> fetchData(id) async {
    var res = await AppService.spotDetail(spotId: id);
    return res as Spot;
  }

  void _changePaginationFilter(int page, int limit) {
    // pageNum.value = page;
    // pageSize.value = limit;
    // _paginationFilter.update((val) {
    //   val.page = page;
    //   val.limit = limit;
    // });
  }

  void handleLogout(isBack) {
    print("LOGOUT APP");
    box.remove("user");
    // _user.close();
    user = User();
    _user.refresh();
    Get.back(closeOverlays: true);
    if(isBack)
      Get.back();
    Get.rawSnackbar(message: "Successfully logout!", backgroundColor: AppColors.success);
  }

  void loadNextPage() => _changePaginationFilter(_page + 1, limit);
}