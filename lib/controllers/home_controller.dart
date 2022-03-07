import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/country_model.dart';
import 'package:vyv/routes/app_routes.dart';

class HomeController extends GetxController {
  // static HomeController get to => Get.find();
  Rx<Country> selectedCountry = Country().obs;
  // static SearchController get searchController => Get.find();
  RxBool showMap = false.obs;
  GetStorage box = GetStorage();

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

}