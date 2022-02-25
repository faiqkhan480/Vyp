import 'package:get/get.dart';
import 'package:vyv/controllers/countries_controller.dart';

class CountriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountryController());
  }
}