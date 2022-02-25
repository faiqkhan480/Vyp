import 'package:flutter/material.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/space.dart';
import 'package:get/get.dart';

import 'button.dart';

class AddFavorite extends StatelessWidget {
  const AddFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: Colors.white,
        child: Form(
          // key: formKey,
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
                  // controller: emailController,
                  decoration: InputDecoration(
                      // isDense: true,
                      // prefixIcon: Padding(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: SvgPicture.asset("assets/images/svgs/blank_card.svg"),
                      // ),
                      // contentPadding: EdgeInsets.zero,
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
                  child: Button("add", isFlat: true, color: AppColors.primaryColor, onPressed: () => null,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
