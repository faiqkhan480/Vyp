import 'package:get/get.dart';
import 'package:vyv/controllers/root_controller.dart';
import 'package:vyv/controllers/search_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootController());
    // Get.put<SearchController>(SearchController());
  }
}