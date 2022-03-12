
import 'package:get/get.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/service/services.dart';

import 'home_controller.dart';

class InfoController extends GetxController {
  Rx<Spot> spot = Spot().obs;
  RxBool loading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<Spot> fetchData(id) async {
    var res = await AppService.spotDetail(spotId: id);
    loading.value = false;
    return res as Spot;
  }
}