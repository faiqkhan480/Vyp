import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vyv/models/user_model.dart';
import 'package:vyv/service/services.dart';
import 'package:vyv/utils/app_colors.dart';

import 'home_controller.dart';

class AuthController extends GetxController {
  HomeController get homeController => Get.find();

  RxBool isLogin = true.obs;
  RxBool loading = false.obs;

  var _date;

  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();


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
  TextEditingController confirmPassword = TextEditingController();

  bool get loginForm => isLogin.value;
  // User get user => _user.value;
  TextEditingController get emailField => emailController.value;
  TextEditingController get passField => passwordController.value;

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
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
    else if (value != passField.text) {
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
    if (loginFormKey.currentState!.validate()) {
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
          "nationality": 0,
          "email": registerEmail.text,
          "birthday": _date,
          "phoneNumber": phone.text,
          "confirmed": true
        };
        var res = await AppService.formSubmit(password: registerPassword.text, body: payload);
        if(res != null) {
          homeController.user = res;
          loading.value = false;
          Get.back(closeOverlays: true);
          Get.rawSnackbar(message: "Account created!", backgroundColor: AppColors.success);
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
}