import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/models/user_model.dart';
import 'package:vyv/service/services.dart';
import 'package:vyv/utils/app_colors.dart';

class AuthController extends GetxController {
  RxBool isLogin = true.obs;
  RxBool loading = false.obs;
  Rx<User> _user = User().obs;

  Rx<User> get user => _user;

  set user(Rx<User> value) {
    _user = value;
  } // FORM KEYS

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
  TextEditingController bDay = TextEditingController();
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

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void handleChange(bool value) => isLogin.value = value;

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      try{
        FocusManager.instance.primaryFocus?.unfocus();
        loading.value = true;
        var res = await AppService.login(emailField.text, passField.text);
        if(res != null) {
          _user.value = res;
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

  // Api Simulation
  Future<bool> checkUser(String user, String password) {
    if (user == 'foo@foo.com' && password == '123') {
      return Future.value(true);
    }
    return Future.value(false);
  }
}