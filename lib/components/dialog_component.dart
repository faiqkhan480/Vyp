import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/components/login_form.dart';
import 'package:vyv/components/signup_form.dart';
import 'package:vyv/controllers/auth_controller.dart';

// class DialogComponent extends StatefulWidget {
//   const DialogComponent({Key? key}) : super(key: key);
//
//   @override
//   _DialogComponentState createState() => _DialogComponentState();
// }

class DialogComponent extends StatelessWidget {

  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Obx(() => controller.isLogin() ? LoginForm(controller: controller,) : SignupForm(controller: controller,)),
    );
  }
}

