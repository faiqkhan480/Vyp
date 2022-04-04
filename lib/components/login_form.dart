import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/auth_controller.dart';

import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

import 'button.dart';

// class LoginForm extends StatefulWidget {
//   final Function(bool) action;
//   const LoginForm({Key? key, required this.action}) : super(key: key);
//
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
class LoginForm extends StatelessWidget {
  final AuthController controller;
  const LoginForm({Key? key, required this.controller}) : super(key: key);
  // // TEXT FIELDS CONTROLLERS
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  //
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: controller.loginFormKey,
        child: Obx(() => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: controller.isForgot() ? 0 : 50, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if(controller.isForgot())
                Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () => controller.changeForm(false),
                        icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg", color: AppColors.primaryColor,)
                    )
                ),

              if(!controller.isForgot())...[
                SvgPicture.asset("assets/images/svgs/img.svg"),
                VerticalSpace(10),
                TextWidget(text: "welcome_back", color: AppColors.primaryColor, size: 2.8, weight: FontWeight.w600, align: TextAlign.center,),

                TextWidget(text: "login_text", size: 1.8, align: TextAlign.center,),
                VerticalSpace(40),
              ],
              // EMAIL FIELD
              Padding(
                padding: EdgeInsets.symmetric(horizontal: controller.isForgot() ? 50 : 0),
                child: TextFormField(
                  controller: controller.emailField,
                  validator: controller.textValidator,
                  decoration: InputDecoration(
                      isDense: true,
                      prefixIconConstraints: BoxConstraints(maxWidth: 40),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                        child: SvgPicture.asset("assets/images/svgs/blank_card.svg"),
                      ),
                      contentPadding: EdgeInsets.zero,
                      // alignLabelWithHint: true,
                      labelText: "email".tr,
                      labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo')
                  ),
                ),
              ),
              if(!controller.isForgot())...[
                VerticalSpace(10),
                // PASSWORD FIELD
                TextFormField(
                  controller: controller.passField,
                  obscureText: true,
                  validator: controller.textValidator,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIconConstraints: BoxConstraints(maxWidth: 40),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                      child: SvgPicture.asset("assets/images/svgs/lock_open.svg"),
                    ),
                    suffixIcon: Button("forgot", onPressed: () => controller.changeForm(true),),
                    contentPadding: EdgeInsets.zero,
                    alignLabelWithHint: true,
                    labelText: "password".tr,
                    labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo'),
                  ),
                ),
              ],
              VerticalSpace(40),
              // LOGIN BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Button(!controller.isForgot() ? "login_upper" : "submit", isFlat: true, color: AppColors.primaryColor, onPressed: controller.handleLogin, loading: controller.loading()),
              ),

              if(!controller.isForgot())...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextWidget(text: "connect_using", size: 1.9, align: TextAlign.center,),
                ),
                // SOCIAL LOGINS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Button("FaceBook", isFlat: true, color: AppColors.success, radius: 5, icon: SvgPicture.asset("assets/images/svgs/fb.svg", height: 18,), onPressed: () => null,)),
                    HorizontalSpace(20),
                    Expanded(child: Button("Google", isFlat: true, color: AppColors.danger, radius: 5, icon: SvgPicture.asset("assets/images/svgs/google.svg"), onPressed: () => null,)),
                  ],
                ),
                VerticalSpace(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(text: "dont_have_account", size: 1.9, align: TextAlign.center,),
                    InkWell(onTap: () => controller.handleChange(false), child: TextWidget(text: "sign_up", size: 1.9, align: TextAlign.center, weight: FontWeight.w700, color: AppColors.primaryColor,)),
                  ],
                ),
              ],
            ],
          ),
        )),
      ),
    );
  }
}
