import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/service/services.dart';
import 'package:vyv/utils/app_colors.dart';

import 'home_controller.dart';

class FavoriteController extends GetxController {
  final bool isFetching;
  FavoriteController({this.isFetching = true});

  HomeController get homeController => Get.find();
  RxBool loading = false.obs;
  GetStorage _box = GetStorage();
  final formKey = GlobalKey<FormState>();
  RxList<Folder> _folders = List<Folder>.empty(growable: true).obs;
  Folder? selectedFolder;

  // TEXT FIELDS CONTROLLERS
  final _nameController = TextEditingController().obs;

  TextEditingController get name => _nameController.value;
  List<Folder> get folders => _folders;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(isFetching);
    if(isFetching) {
      fetchAllFavorites().then((value) => fetchFolders());
    }
    else if(_box.read('folders') != null)
      folders.assignAll(folderFromMap(_box.read('folders')));
  }

  Future fetchFolders() async {
    try{
      loading.value = true;
      var res = await AppService.getFolders(homeController.user!.id);
      if(res != null ) {
        _box.write("folders", folderToMap(res));
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

  Future fetchAllFavorites() async {}

  Future addToFav(Spot _spot) async {
    try{
      if(formKey.currentState!.validate()) {
        FocusManager.instance.primaryFocus?.unfocus();
        loading.value = true;
        var res = await AppService.addFavorite(idUser: homeController.user?.id, idSpot: _spot.id, imageStr: _spot.imageStr ?? " ", favoriteName: selectedFolder?.folderName, idFolder: selectedFolder?.folderId);
        if(res != null) {
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

  Future createFolder() async {
    try{
      if(formKey.currentState!.validate()) {
        FocusManager.instance.primaryFocus?.unfocus();
        loading.value = true;
        var res = await AppService.createFolder(name: name.text, userId: homeController.user!.id);
        if(res != null) {
          folders.add(res);
          _box.write("folders", folderToMap(folders));
          loading.value = false;
          Get.back(closeOverlays: true);
          if(res is String)
            Get.rawSnackbar(message: res.toString(), backgroundColor: AppColors.success);
          else
            Get.rawSnackbar(message: "Folder created", backgroundColor: AppColors.success);
          name.clear();
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
}