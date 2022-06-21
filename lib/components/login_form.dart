import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/auth_controller.dart';

import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
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
                Align(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.lightGrey,
                            blurRadius: 3.0,
                            offset: Offset(2.0, 5.0)
                          ),
                        ]
                    ),
                    alignment: Alignment.center,
                    height: 70,
                    width: 150,
                    child:  TextWidget(
                      text: Constants.appName,
                      color: AppColors.primaryColor,
                      size: 5,
                      align: TextAlign.center,
                      family: 'GemunuLibre',
                    ),
                  ),
                ),
                VerticalSpace(20),
                TextWidget(text: "welcome_back", color: AppColors.primaryColor, size: 2.8, weight: FontWeight.w700, align: TextAlign.center,),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(color: AppColors.black, fontSize: SizeConfig.textMultiplier * 1.8),
                      text: "login_text".tr,
                      children: [
                          TextSpan(text: Constants.appName, style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w700))
                      ]
                  ),
                ),
                VerticalSpace(40),
              ],
              // EMAIL FIELD
              Padding(
                padding: EdgeInsets.symmetric(horizontal: controller.isForgot() ? 50 : 0),
                child: TextFormField(
                  controller: controller.emailField,
                  validator: controller.emailValidator,
                  keyboardType: TextInputType.emailAddress,
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
                child: Button(
                    !controller.isForgot() ? "login_upper" : "submit",
                    isFlat: true,
                    color: AppColors.primaryColor,
                    onPressed: controller.handleLogin,
                    loading: controller.loading(),
                    radius: 10,
                ),
              ),

              if(!controller.isForgot())...[
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 15.0),
                //   child: TextWidget(text: "connect_using", size: 1.9, align: TextAlign.center,),
                // ),
                // SOCIAL LOGINS
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Expanded(child: Button("FaceBook", isFlat: true, color: AppColors.success, radius: 5, icon: SvgPicture.asset("assets/images/svgs/fb.svg", height: 18,), onPressed: () => null,)),
                //     HorizontalSpace(20),
                //     Expanded(child: Button("Google", isFlat: true, color: AppColors.danger, radius: 5, icon: SvgPicture.asset("assets/images/svgs/google.svg"), onPressed: () => null,)),
                //   ],
                // ),
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
