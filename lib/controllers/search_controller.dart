import 'package:get/get.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/models/district.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/service/services.dart';

class SearchController extends GetxController {
  static SearchController get searchController => Get.find();

  RxBool isFetching = false.obs;
  Rx<Country> selectedCountry = Country().obs;
  List<District> districts = List<District>.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setCountry(Country c) => selectedCountry.value = c;

  fetchDistricts() async {
    try{
      isFetching.value = true;
      var res = await Service.getDistricts(selectedCountry.value.id!);
      if(res != null) {
        districts.assignAll(res);
        isFetching.value = false;
        Get.offNamed(AppRoutes.ROOT);
      }
      else {
        isFetching.value = false;
      }
    }
    catch (e) {
      print(e);
    }
  }
}