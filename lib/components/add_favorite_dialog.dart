import 'package:flutter/material.dart';
import 'package:vyv/controllers/favorite_controller.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/space.dart';
import 'package:get/get.dart';

import 'button.dart';

class AddFavorite extends StatelessWidget {
  final FavoriteController controller;
  const AddFavorite(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: Colors.white,
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SvgPicture.asset("assets/images/svgs/img.svg"),
                VerticalSpace(10),
                //  NAME FIELD
                TextFormField(
                  controller: controller.name,
                  validator: _validator,
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "name".tr,
                      labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo')
                  ),
                ),
                VerticalSpace(10),
                VerticalSpace(40),
                // LOGIN BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Button(
                    "create",
                    isFlat: true,
                    color: AppColors.primaryColor,
                    onPressed: controller.createFolder,
                    loading: controller.loading(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validator(String? val) {
    if(val!.isEmpty)
      return "Folder name is required!";
    else
      return null;
  }
}
