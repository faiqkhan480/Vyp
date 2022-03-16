import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/service/services.dart';
import 'package:vyv/utils/app_colors.dart';

import 'home_controller.dart';

class FavoriteController extends GetxController {
  HomeController get homeController => Get.find();
  RxBool loading = false.obs;
  final formKey = GlobalKey<FormState>();
  RxList<Folder> _folders = List<Folder>.empty(growable: true).obs;

  // TEXT FIELDS CONTROLLERS
  final _nameController = TextEditingController().obs;

  TextEditingController get name => _nameController.value;
  List<Folder> get folders => _folders;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchFolders();
  }

  Future createFolder() async {
    try{
      if(formKey.currentState!.validate()) {
        FocusManager.instance.primaryFocus?.unfocus();
        loading.value = true;
        var res = await AppService.createFolder(name: name.text, userId: homeController.user!.id);
        if(res != null) {
          loading.value = false;
          Get.back(closeOverlays: true);
          Get.rawSnackbar(message: res.toString(), backgroundColor: AppColors.success);
        }
      }
    }
    catch (e) {
      print("error: $e");
    }
    finally {
      loading.value = false;
    }
  }

  Future fetchFolders() async {
    try{
      loading.value = true;
      var res = await AppService.getFolders(homeController.user!.id);
      if(res != null ) {
        folders.assignAll(res);
      }
      loading.value = false;
    }
    catch (e) {
      print("error: $e");
    }
    finally {
      loading.value = false;
    }
  }

  Future fetchFavorites() async {}
}