import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/service/services.dart';

class HomeController extends GetxController {
  // static HomeController get to => Get.find();
  Rx<Country> selectedCountry = Country().obs;
  // static SearchController get searchController => Get.find();
  RxBool showMap = false.obs;
  RxBool loading = false.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 5.obs;
  GetStorage box = GetStorage();
  RxList<Spot> spots = List<Spot>.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(box.read("country") != null)
      selectedCountry.value = Country.fromMap(box.read("country"));
  }

  changeView() {
    print("CALLED::::::");
    showMap.value = !showMap.value;
  }

  void setCountry(Country c) {
    selectedCountry.value = c;
    // Get.offNamed(AppRoutes.ROOT);
  }

  void handleSearch({reqIds}) async {
    // Get.back();
    try{
      loading.value = true;
      Map<String, dynamic> params = {
        // "categoryId": categoryIds,
        // "districtId": districtIds,
        // "countyId": countyIds,
        "PageNumber": pageNum.value,
        "PageSize": pageSize.value
      };
      // if(reqIds != null)
      //   params.addAll(reqIds);
      var res = await AppService.searchSpot(payload: params);
      if(res != null) {
        spots.assignAll(res);
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
}