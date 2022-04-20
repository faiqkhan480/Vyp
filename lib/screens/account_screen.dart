import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final HomeController _controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: setPage(),

      // body: SingleChildScrollView(
      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       // NAME FIELD
      //       TextFormField(
      //         readOnly: true,
      //         controller: TextEditingController(text: "${_controller.user!.firstName} ${_controller.user!.lastName}"),
      //         decoration: InputDecoration(
      //             isDense: true,
      //             labelText: "name".tr,
      //             labelStyle: TextStyle(color: AppColors.grey, fontFamily: 'Heebo'),
      //             focusedBorder: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(18.0),
      //               borderSide: BorderSide(color: AppColors.primaryColor),
      //             ),
      //             enabledBorder: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(18.0),
      //               borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
      //             // borderSide: BorderSide(color: Colors.white),
      //             ),
      //         ),
      //       ),
      //       VerticalSpace(40),
      //       // EMAIL FIELD
      //       TextFormField(
      //         readOnly: true,
      //         controller: TextEditingController(text: _controller.user!.email),
      //         decoration: InputDecoration(
      //           isDense: true,
      //           labelText: "email".tr,
      //           labelStyle: TextStyle(color: AppColors.grey, fontFamily: 'Heebo'),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(18.0),
      //             borderSide: BorderSide(color: AppColors.primaryColor),
      //           ),
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(18.0),
      //             borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
      //             // borderSide: BorderSide(color: Colors.white),
      //           ),
      //         ),
      //       ),
      //       VerticalSpace(40),
      //       // PHONE FIELD
      //       TextFormField(
      //         readOnly: true,
      //         controller: TextEditingController(text: _controller.user!.phoneNumber),
      //         decoration: InputDecoration(
      //           isDense: true,
      //           labelText: "phone".tr,
      //           labelStyle: TextStyle(color: AppColors.grey, fontFamily: 'Heebo'),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(18.0),
      //             borderSide: BorderSide(color: AppColors.primaryColor),
      //           ),
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(18.0),
      //             borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
      //             // borderSide: BorderSide(color: Colors.white),
      //           ),
      //         ),
      //       ),
      //       VerticalSpace(40),
      //       // BIRTHDAY FIELD
      //       TextFormField(
      //         readOnly: true,
      //         controller: TextEditingController(text: "${DateFormat("dd-MMM-yyyy").format(_controller.user!.birthday!)}"),
      //         decoration: InputDecoration(
      //           isDense: true,
      //           labelText: "Birthday".tr,
      //           labelStyle: TextStyle(color: AppColors.grey, fontFamily: 'Heebo'),
      //           focusedBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(18.0),
      //             borderSide: BorderSide(color: AppColors.primaryColor),
      //           ),
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(18.0),
      //             borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.4)),
      //             // borderSide: BorderSide(color: Colors.white),
      //           ),
      //         ),
      //       ),
      //       VerticalSpace(40),
      //     ],
      //   ),
      // ),
    );
  }

  Widget custom() {
    return AppBar(
      backgroundColor: Colors.white,
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
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(30),
      //   ),
      // ),
      // flexibleSpace: Container(
      //   height: SizeConfig.heightMultiplier * 20,
      //   child: TextWidget(
      //     text: "${_controller.user!.firstName} ${_controller.user!.lastName}",
      //     size: 3.0,
      //     weight: FontWeight.w300,
      //     align: TextAlign.center,
      //   ),
      // ),
    );
  }

  Widget setPage() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Center(
                child: TextWidget(
                  text: Constants.appName,
                  color: AppColors.primaryColor,
                  size: 5,
                  align: TextAlign.center,
                  family: 'GemunuLibre',
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                ),
                height: SizeConfig.heightMultiplier * 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/svgs/user.svg", color: AppColors.black, height: 26,),
                    TextWidget(
                      text: "\t${_controller.user!.firstName} ${_controller.user!.lastName}",
                      size: 4.0,
                      weight: FontWeight.w300,
                      align: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
          height: Get.height * 0.4,
          width: Get.width,
        ),

        Container(),   // Required some widget in between to float AppBar

        Positioned(
            top: 50.0,
            child: IconButton(onPressed: () => Get.back(canPop: true, id: 1), icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg"))),

        Positioned(    // To take AppBar Size only
          top: 280.0,
          left: 40.0,
          right: 40.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.lightGrey,
                      blurRadius: 3.0,
                      offset: Offset(2.0, 5.0)
                  ),
                ]
            ),
            alignment: Alignment.center,
            height: 100,
            width: 150,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _section("Guides", 7),
                VerticalDivider(color: AppColors.black, thickness: 1,),
                _section("Favorites", 2),
                VerticalDivider(color: AppColors.black, thickness: 1,),
                _section("Events", 0),
              ],
            )
          ),
        )
      ],
    );
  }

  Widget _section(String title, int val) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextWidget(
        text: title,
        size: 2.5,
        align: TextAlign.center,
        weight: FontWeight.w300,
      ),
      TextWidget(
        text: val.toString(),
        color: AppColors.primaryColor,
        size: 2.5,
        align: TextAlign.center,
        weight: FontWeight.w700,
      ),
    ],
  );
}
