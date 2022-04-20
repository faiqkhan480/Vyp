import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vyv/components/button.dart';
import 'package:vyv/components/dialog_component.dart';
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(flex: 2, child: setPage()),

              Flexible(
                flex: 2,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    VerticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/svgs/mail.svg"),
                        HorizontalSpace(20),
                        TextWidget(
                          text: _controller.user?.email ?? "",
                          size: 2.5,
                          align: TextAlign.center,
                          weight: FontWeight.w300,
                        ),
                      ],
                    ),
                    VerticalSpace(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/svgs/mobile.svg"),
                        HorizontalSpace(20),
                        TextWidget(
                          text: _controller.user?.email ?? "",
                          size: 2.5,
                          align: TextAlign.center,
                          weight: FontWeight.w300,
                        ),
                      ],
                    ),
                    VerticalSpace(30),
                    InkWell(
                      onTap: () =>  Get.dialog(DialogComponent(isReset: true,), barrierDismissible: true, useSafeArea: true),
                      child: TextWidget(
                        text: "reset_password",
                        size: 2.5,
                        align: TextAlign.center,
                        weight: FontWeight.w700,
                      ),
                    ),

                    // Spacer(),

                    // Spacer(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: logoutButton()
          )
        ],
      ),
    );
  }

  Widget logoutButton() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 150.0),
    child: Button(
      "log_out".tr,
      isFlat: true,
      color: AppColors.primaryColor,
      onPressed: _controller.handleLogout,
      loading: _controller.loading(),
    ),
  );

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
