import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vyv/models/user_model.dart';
import 'package:vyv/service/services.dart';
import 'package:vyv/utils/app_colors.dart';

import 'favorite_controller.dart';
import 'home_controller.dart';

class AuthController extends GetxController {
  HomeController get homeController => Get.find();

  RxBool isLogin = true.obs;
  RxBool loading = false.obs;
  RxBool fetching = true.obs;
  RxBool isForgot = false.obs;

  var _date;
  Map<String, dynamic>? nationalities;
  var selectedNationality;

  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();


  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  // SIGNUP FORM FIELDS
  // TEXT FIELDS CONTROLLERS
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool get loginForm => isLogin.value;
  // User get user => _user.value;
  TextEditingController get emailField => emailController.value;
  TextEditingController get passField => passwordController.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNationalities();
  }

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }

  void fetchNationalities() async {
    try {
      var res = await AppService.getAllNationality();
      if(res != null)
        nationalities = res;
      fetching.value = false;
    }
    catch(e){
      print("Error: $e");
    }
    finally {
      fetching.value = false;
    }
  }

  String? textValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    }
    else if (value.length < 3) {
    return 'Length is too short';
    }
    return null;
  }

  String? confirmPassValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    }
    else if (value != registerPassword.text) {
    return "confirm password not matching";
    }
    return null;
  }

  void handleChange(bool value) => isLogin.value = value;
  
  void handleDatePicker() async {
    DateTime? date = await showDatePicker(context: Get.context!, initialDate: DateTime.now().subtract(Duration(days: 30)), firstDate: DateTime(1980), lastDate: DateTime.now());
    print(date);
    if(date != null) {
      _date = date.toIso8601String();
      birthday.text = DateFormat("yyyy MM dd").format(date);
    }
  }
  
  void handleLogin() async {
    if(isForgot.isTrue)
      handleForgot();
    else if (loginFormKey.currentState!.validate()) {
      try{
        FocusManager.instance.primaryFocus?.unfocus();
        loading.value = true;
        var res = await AppService.formSubmit(email: emailField.text, password: passField.text);
        if(res != null) {
          // homeController.user = res;
          homeController.setValue(res);
          // print(homeController.user!.id);
          loading.value = false;
          Get.back(closeOverlays: true);
          Get.rawSnackbar(message: "Successfully login!", backgroundColor: AppColors.success);
        }
        else {
          loading.value = false;
        }
      }
      catch (e) {
        print(e);
      }
      finally {
        loading.value = false;
      }
    }
  }
  
  void handleRegister() async {
    if (signUpFormKey.currentState!.validate()) {
      try{
        FocusManager.instance.primaryFocus?.unfocus();
        loading.value = true;
        var payload = {
          "id": 0,
          "firstName": firstName.text,
          "lastName": lastName.text,
          "nationality": int.parse(selectedNationality),
          "email": registerEmail.text,
          "birthday": _date,
          "phoneNumber": phone.text,
          "confirmed": true
        };
        User? res = await AppService.formSubmit(password: registerPassword.text, body: payload);
        if(res != null) {
          homeController.user = res;
          // loading.value = false;
          // Get.back(closeOverlays: true);
          // Get.find<FavoriteController>().name.text = "All";
          await Get.find<FavoriteController>().createFolder(folderName: "All", userID: res.id);
          Get.rawSnackbar(message: "Account created!", backgroundColor: AppColors.success);
          handleChange(true);
        }
        else {
          loading.value = false;
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

  void handleReset() async {
    if (resetFormKey.currentState!.validate()) {
      try{
        FocusManager.instance.primaryFocus?.unfocus();
        loading.value = true;
        Map<String, dynamic> _params = {
          "oldPassword": newPassword.text,
          "newPassword": confirmPassword.text,
        };
        var res = await AppService.resetPass(userId: homeController.user!.id, payload: _params);
        if(res != null) {
          loading.value = false;
          Get.back(closeOverlays: true);
          Get.rawSnackbar(message: res, backgroundColor: AppColors.success);
        }
        else {
          loading.value = false;
        }
      }
      catch (e) {
        print(e);
      }
      finally {
        loading.value = false;
      }
    }
  }

  void changeForm(bool val) => isForgot.value = val;

  void handleForgot() async {
    if (loginFormKey.currentState!.validate()) {
      try{

      }
      catch (e) {
        print(e);
      }
      finally {
        loading.value = false;
      }
    }
  }
}