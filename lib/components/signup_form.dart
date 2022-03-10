import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/auth_controller.dart';

import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

import 'button.dart';
import 'dialog_component.dart';

// class SignupForm extends StatefulWidget {
//   final Function(bool) action;
//   const SignupForm({Key? key, required this.action}) : super(key: key);
//
//   @override
//   _SignupFormState createState() => _SignupFormState();
// }

class SignupForm extends StatelessWidget {
  final AuthController controller;
  const SignupForm({Key? key, required this.controller}) : super(key: key);
  
  // // TEXT FIELDS CONTROLLERS
  // TextEditingController firstNameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController nationalityController = TextEditingController();
  // TextEditingController bDayController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmController = TextEditingController();
  //
  // String dropdownValue = '';
  //
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Form(
        key: controller.signUpFormKey,
        child: CupertinoScrollbar(
          child: ListView(
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              // BACK BUTTON
              Align(
                alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () => controller.handleChange(true),
                      icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg", color: AppColors.primaryColor,)
                  )
              ),

              TextWidget(text: "let_get_started", color: AppColors.primaryColor, size: 2.8, weight: FontWeight.w600, align: TextAlign.center,),
              TextWidget(text: "signup_text", size: 1.8, align: TextAlign.center,),
              // FIRST/LAST NAME
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(child: TextFormField(
                      controller: controller.firstName,
                      decoration: InputDecoration(
                          isDense: true,
                          prefixIconConstraints: BoxConstraints(maxWidth: 40),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                            child: SvgPicture.asset("assets/images/svgs/user.svg"),
                          ),
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelText: "first_name".tr,
                          labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
                      ),
                    ),),
                    HorizontalSpace(20),
                    Expanded( child: TextFormField(
                      controller: controller.lastName,
                      decoration: InputDecoration(
                          // isDense: true,
                          // prefixIconConstraints: BoxConstraints(
                          //   minWidth: 5,
                          //   minHeight: 48,
                          // ),
                          // prefixIcon: Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 15.0),
                          // // child: SvgPicture.asset("assets/images/svgs/blank_card.svg"),
                          // ),
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelText: "last_name".tr,
                          labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
                      ),
                    ),),
                  ],
                ),
              ),
              // EMAIL FIELD
              TextFormField(
                controller: controller.registerEmail,
                decoration: InputDecoration(
                    isDense: true,
                    prefixIconConstraints: BoxConstraints(maxWidth: 40),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                      child: SvgPicture.asset("assets/images/svgs/blank_card.svg"),
                    ),
                    contentPadding: EdgeInsets.zero,
                    alignLabelWithHint: true,
                    labelText: "email".tr,
                    labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
                ),
              ),
              VerticalSpace(10),
              // PHONE FIELD
              TextFormField(
                controller: controller.phone,
                decoration: InputDecoration(
                    isDense: true,
                    prefixIconConstraints: BoxConstraints(maxWidth: 40),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                      child: SvgPicture.asset("assets/images/svgs/phone_square.svg"),
                    ),
                    contentPadding: EdgeInsets.zero,
                    alignLabelWithHint: true,
                    labelText: "phone".tr,
                    labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
                ),
              ),
              // BIRTHDATE & NATIONALITY
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        hint: Text("nationality".tr, style: TextStyle(color: AppColors.greyScale.withOpacity(0.7), fontFamily: 'Heebo', fontWeight: FontWeight.w300),),
                        // value: dropdownValue,
                        icon:  SvgPicture.asset("assets/images/svgs/arrow_down.svg"),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (String? newValue) {
                          // setState(() => dropdownValue = newValue!);
                        },
                        items: <String>['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    HorizontalSpace(20),
                    Expanded(child: TextFormField(
                      controller: controller.bDay,
                      decoration: InputDecoration(
                          // isDense: true,
                          // prefixIcon: Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 15.0),
                          //   // child: SvgPicture.asset("assets/images/svgs/blank_card.svg"),
                          // ),
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelText: "b_day".tr,
                          labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
                      ),
                    ),),
                  ],
                ),
              ),
              // PASSWORD FIELD
              TextFormField(
                controller: controller.registerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIconConstraints: BoxConstraints(maxWidth: 40),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                    child: SvgPicture.asset("assets/images/svgs/lock_open.svg"),
                  ),
                  contentPadding: EdgeInsets.zero,
                  alignLabelWithHint: true,
                  labelText: "password".tr,
                  labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300),
                ),
              ),
              // CONFIRM PASSWORD
              TextFormField(
                controller: controller.confirmPassword,
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIconConstraints: BoxConstraints(maxWidth: 40),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                    child: SvgPicture.asset("assets/images/svgs/lock_open.svg"),
                  ),
                  contentPadding: EdgeInsets.zero,
                  alignLabelWithHint: true,
                  labelText: "confirm_password".tr,
                  labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300),
                ),
              ),
              // LOGIN BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 20),
                child: Button("create_upper", isFlat: true, color: AppColors.primaryColor, onPressed: () => null,),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(text: "already_have_account", size: 1.5, align: TextAlign.center,),
                  InkWell(onTap: () => controller.handleChange(true), child: TextWidget(text: "sign_in", size: 1.5, align: TextAlign.center, weight: FontWeight.w700, color: AppColors.primaryColor,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
