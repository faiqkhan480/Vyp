import 'package:get/get.dart';
import 'package:vyv/controllers/search_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  // static SearchController get searchController => Get.find();

  RxBool showMap = false.obs;


  changeView() {
    print("CALLED::::::");
    showMap.value = !showMap.value;
  }
}