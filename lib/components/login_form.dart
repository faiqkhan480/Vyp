import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

import 'dialog_component.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(text: "welcome_back", color: AppColors.primaryColor, size: 2.8, weight: FontWeight.w600, align: TextAlign.center,),

            TextWidget(text: "login_text", size: 1.8, align: TextAlign.center,),
            VerticalSpace(30),
            // EMAIL FIELD
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset("assets/images/svgs/blank_card.svg"),
                  ),
                  contentPadding: EdgeInsets.zero,
                  alignLabelWithHint: true,
                  labelText: "email".tr,
                  labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo')
              ),
            ),
            VerticalSpace(10),
            // PASSWORD FIELD
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset("assets/images/svgs/lock_open.svg"),
                ),
                suffixIcon: Button("forgot", onPressed: () => null,),
                contentPadding: EdgeInsets.zero,
                alignLabelWithHint: true,
                labelText: "password".tr,
                labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo'),
              ),
            ),
            VerticalSpace(40),
            // LOGIN BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Button("LOG IN", isFlat: true, color: AppColors.primaryColor, onPressed: () => null,),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextWidget(text: "connect_using", size: 1.5, align: TextAlign.center,),
            ),
            // SOCIAL LOGINS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Button("FaceBook", isFlat: true, color: AppColors.success, radius: 5, onPressed: () => null,)),
                HorizontalSpace(20),
                Expanded(child: Button("Google", isFlat: true, color: AppColors.danger, radius: 5, onPressed: () => null,)),
              ],
            ),
            VerticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(text: "dont_have_account", size: 1.5, align: TextAlign.center,),
                InkWell(onTap: () => null, child: TextWidget(text: "sign_up", size: 1.5, align: TextAlign.center, weight: FontWeight.w700, color: AppColors.primaryColor,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
