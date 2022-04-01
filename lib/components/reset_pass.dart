import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vyv/components/button.dart';
import 'package:vyv/controllers/auth_controller.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class ResetPassDialog extends StatelessWidget {
  final AuthController controller;
  const ResetPassDialog({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: controller.resetFormKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(text: "reset_password", size: 1.8, align: TextAlign.center,),
              VerticalSpace(40),
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
                  contentPadding: EdgeInsets.zero,
                  alignLabelWithHint: true,
                  labelText: "old_password".tr,
                  labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo'),
                ),
              ),
              VerticalSpace(10),
              // CONFIRM PASSWORD FIELD
              TextFormField(
                controller: controller.confirmPassword,
                obscureText: true,
                validator: controller.textValidator,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIconConstraints: BoxConstraints(maxWidth: 40),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
                    child: SvgPicture.asset("assets/images/svgs/lock_open.svg"),
                  ),
                  contentPadding: EdgeInsets.zero,
                  alignLabelWithHint: true,
                  labelText: "new_password".tr,
                  labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo'),
                ),
              ),
              VerticalSpace(40),
              // SUBMIT BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Button("submit", isFlat: true, color: AppColors.primaryColor, onPressed: controller.handleReset, loading: controller.loading()),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
