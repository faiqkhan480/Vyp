import 'package:get/get.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // Get.put<SearchController>(SearchController());
  }
}