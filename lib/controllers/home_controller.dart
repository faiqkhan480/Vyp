import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxBool showMap = false.obs;


  changeView() {
    print("CALLED::::::");
    showMap.value = !showMap.value;
  }
}