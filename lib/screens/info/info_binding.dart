import 'package:get/get.dart';
// import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/info_controller.dart';

class InfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoController>(() => InfoController());
    // Get.put<InfoController>(InfoController());
  }
}