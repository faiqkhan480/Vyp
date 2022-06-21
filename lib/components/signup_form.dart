import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controllers/auth_controller.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/space.dart';
import '../widgets/text_component.dart';

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
      child: Form(
        key: controller.signUpFormKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              // BACK BUTTON
              Row(
                children: [
                  IconButton(
                      onPressed: () => controller.handleChange(true),
                      icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg", color: AppColors.primaryColor,)
                  ),
                  Spacer(),
                  TextWidget(text: "let_get_started", color: AppColors.primaryColor, size: 2.8, weight: FontWeight.w700, align: TextAlign.center,),
                  Spacer(),
                  Spacer(),
                ],
              ),
              TextWidget(text: "signup_text", size: 1.8, align: TextAlign.center,),
              // FIRST/LAST NAME
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(child: TextFormField(
                      controller: controller.firstName,
                      validator: controller.textValidator,
                      maxLength: 30,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[A-Za-zÀ-ȕ]")),
                      ],
                      keyboardType: TextInputType.name,
                      decoration: StyleProperties.prefixField(iconPath: "assets/images/svgs/user.svg", label: "first_name".tr),
                    ),),
                    HorizontalSpace(20),
                    Expanded(
                      child: TextFormField(
                        controller: controller.lastName,
                        validator: controller.textValidator,
                        maxLength: 30,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[A-Za-zÀ-ȕ]")),
                        ],
                        keyboardType: TextInputType.name,
                        decoration: StyleProperties.inputDecoration(label: "last_name".tr),
                    ),),
                  ],
                ),
              ),
              // EMAIL FIELD
              TextFormField(
                controller: controller.registerEmail,
                validator: controller.emailValidator,
                keyboardType: TextInputType.emailAddress,
                decoration: StyleProperties.prefixField(iconPath: "assets/images/svgs/blank_card.svg", label: "email".tr),
              ),
              VerticalSpace(10),
              // PHONE FIELD
              IntlPhoneField(
                controller: controller.phone,
                initialCountryCode: "PT",
                onChanged: (val) {
                  controller.setCountryCode(val.countryCode);
                },
                onCountryChanged: (val) {
                  controller.setCountryCode(val.dialCode);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: InputDecoration(
                    isDense: true,
                    counter: SizedBox(),
                    // prefixIcon: Padding(
                    //   padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                    //   child: SvgPicture.asset("assets/images/svgs/phone_square.svg"),
                    // ),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.black, width: 2)),
                    contentPadding: EdgeInsets.only(bottom: 15),
                    alignLabelWithHint: true,
                    labelText: "phone".tr,
                    labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
                ),
              ),
              // TextFormField(
              //   controller: controller.phone,
              //   validator: controller.textValidator,
              //   decoration: StyleProperties.prefixField(iconPath: "assets/images/svgs/phone_square.svg", label: "phone".tr),
              // ),
              // BIRTHDATE & NATIONALITY
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: controller.fetching() ?
                      Center(child: CircularProgressIndicator(),) :
                      DropdownButtonFormField<String>(
                        hint: Text("nationality".tr, style: TextStyle(color: AppColors.greyScale.withOpacity(0.7), fontFamily: 'Heebo', fontWeight: FontWeight.w300),),
                        value: controller.selectedNationality,
                        icon:  SvgPicture.asset("assets/images/svgs/arrow_down.svg"),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (newValue) {
                          controller.selectedNationality = newValue!;
                          // setState(() => dropdownValue = newValue!);
                        },
                        items: controller.nationalities!.keys.toList().map<DropdownMenuItem<String>>((String? entry) {
                          return DropdownMenuItem(
                            value: entry,
                            child: Text(controller.nationalities![entry]),
                          );
                        }).toList(),
                      ),
                    ),
                    // HorizontalSpace(20),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: controller.birthday,
                        readOnly: true,
                        onTap: controller.handleDatePicker,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            alignLabelWithHint: true,
                            labelText: "b_day".tr,
                            labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
                        ),
                      ),
                    ),),
                  ],
                ),
              ),
              // PASSWORD FIELD
              TextFormField(
                controller: controller.registerPassword,
                validator: controller.passwordValidator,
                obscureText: true,
                decoration: StyleProperties.prefixField(iconPath: "assets/images/svgs/lock_open.svg", label: "password".tr),
              ),
              // CONFIRM PASSWORD
              TextFormField(
                controller: controller.confirmPassword,
                validator: controller.confirmPassValidator,
                obscureText: true,
                decoration: StyleProperties.prefixField(iconPath: "assets/images/svgs/lock_open.svg", label: "confirm_password".tr),
              ),
              // LOGIN BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 20),
                child: Button("create_upper", isFlat: true, color: AppColors.primaryColor, onPressed: controller.handleRegister, loading: controller.loading(),),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(text: "already_have_account", size: 1.5, align: TextAlign.center,),
                  InkWell(onTap: () => controller.handleChange(true), child: TextWidget(text: "sign_in", size: 1.5, align: TextAlign.center, weight: FontWeight.w700, color: AppColors.primaryColor,)),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
