import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final HomeController _controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: TextWidget(
          text: Constants.appName,
          color: AppColors.primaryColor,
          size: 5,
          align: TextAlign.center,
          family: 'GemunuLibre',
        ),
        leading: IconButton(onPressed: () => Get.back(canPop: true, id: 1), icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg")),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // NAME FIELD
            TextFormField(
              readOnly: true,
              controller: TextEditingController(text: "${_controller.user!.firstName} ${_controller.user!.lastName}"),
              decoration: InputDecoration(
                  isDense: true,
                  labelText: "name".tr,
                  labelStyle: TextStyle(color: AppColors.grey, fontFamily: 'Heebo'),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
                  // borderSide: BorderSide(color: Colors.white),
                  ),
              ),
            ),
            VerticalSpace(40),
            // EMAIL FIELD
            TextFormField(
              readOnly: true,
              controller: TextEditingController(text: _controller.user!.email),
              decoration: InputDecoration(
                isDense: true,
                labelText: "email".tr,
                labelStyle: TextStyle(color: AppColors.grey, fontFamily: 'Heebo'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
                  // borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            VerticalSpace(40),
            // PHONE FIELD
            TextFormField(
              readOnly: true,
              controller: TextEditingController(text: _controller.user!.phoneNumber),
              decoration: InputDecoration(
                isDense: true,
                labelText: "phone".tr,
                labelStyle: TextStyle(color: AppColors.grey, fontFamily: 'Heebo'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
                  // borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            VerticalSpace(40),
            // BIRTHDAY FIELD
            TextFormField(
              readOnly: true,
              controller: TextEditingController(text: "${DateFormat("dd-MMM-yyyy").format(_controller.user!.birthday!)}"),
              decoration: InputDecoration(
                isDense: true,
                labelText: "Birthday".tr,
                labelStyle: TextStyle(color: AppColors.grey, fontFamily: 'Heebo'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
                  // borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            VerticalSpace(40),
          ],
        ),
      ),
    );
  }
}
