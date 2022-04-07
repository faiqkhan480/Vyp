import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/controllers/favorite_controller.dart';
import 'package:vyv/models/folder_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/space.dart';
import 'package:get/get.dart';
import 'package:vyv/widgets/text_component.dart';

import 'button.dart';

class AddFavorite extends StatelessWidget {
  final FavoriteController? controller;
  final Spot? spot;
  const AddFavorite({Key? key, this.controller, this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool forFolder = spot == null;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Form(
              key: controller!.formKey,
              child: Obx(() => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SvgPicture.asset("assets/images/svgs/img.svg"),
                    VerticalSpace(20),
                    if(!forFolder)...[
                      TextWidget(text: spot!.spotName.toString()),
                      DropdownButtonFormField<Folder>(
                        hint: Text("select_folder".tr, style: TextStyle(color: AppColors.greyScale.withOpacity(0.7), fontFamily: 'Heebo', fontWeight: FontWeight.w300),),
                        value: controller!.selectedFolder,
                        icon:  SvgPicture.asset("assets/images/svgs/arrow_down.svg"),
                        elevation: 16,
                        validator: (value) => value == null ? "select_the_folder".tr : null,
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (Folder? newValue) {
                          controller!.selectedFolder = newValue!;
                        },
                        items: controller!.folders.map<DropdownMenuItem<Folder>>((Folder value) {
                          return DropdownMenuItem<Folder>(
                            value: value,
                            child: Text(value.folderName.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                    //  NAME FIELD
                    if(forFolder)
                      TextFormField(
                        controller: controller!.name,
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
                        forFolder ? "create" : "add",
                        isFlat: true,
                        color: AppColors.primaryColor,
                        onPressed: () => forFolder ? controller!.createFolder() : controller!.addToFav(spot!),
                        loading: controller!.loading(),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),

          Positioned(
              right: 5,
              child: IconButton(icon: Icon(Icons.close_rounded), onPressed: () => Get.back(closeOverlays: true),))
        ],
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
