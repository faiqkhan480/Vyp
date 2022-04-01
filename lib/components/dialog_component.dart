import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/components/login_form.dart';
import 'package:vyv/components/reset_pass.dart';
import 'package:vyv/components/signup_form.dart';
import 'package:vyv/controllers/auth_controller.dart';

// class DialogComponent extends StatefulWidget {
//   const DialogComponent({Key? key}) : super(key: key);
//
//   @override
//   _DialogComponentState createState() => _DialogComponentState();
// }

class DialogComponent extends StatefulWidget {
  final bool isReset;
  DialogComponent({this.isReset = false});
  @override
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {
  AuthController controller = Get.put(AuthController());

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<AuthController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: widget.isReset ?
      ResetPassDialog(controller: controller):
      Obx(() => controller.isLogin() ?
      LoginForm(controller: controller,) : 
      SignupForm(controller: controller,)
      ),
    );
  }
}

