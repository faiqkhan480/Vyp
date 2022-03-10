import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/components/dialog_component.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

import 'info_sheet.dart';

class MenuSheet extends StatelessWidget {
  final bool isLogin;
  final bool isItemMenu;
  final Spot? spot;
  const MenuSheet({Key? key, required this.isLogin, this.isItemMenu = false, this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List menu = isLogin ? loginMenu : isItemMenu ? itemMenu : guestMenu;
    // List menu = loginMenu;
    return Container(
        color: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(vertical: 10),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(isItemMenu)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(text: spot?.spotName, size: 2.5,),
            ),

            Wrap(
              children: List.generate(
                menu.length,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          leading: menu.elementAt(index).entries.last.value,
                          title: TextWidget(
                            text: menu.elementAt(index).entries.first.value.toString(),
                            size: 1.8,
                          ),
                          // subtitle: Divider(thickness: 1, height: 1,),
                          dense: true,
                          // contentPadding: EdgeInsets.only(top: 3, bottom: 5),
                          onTap: () => handleClick(menu.elementAt(index).entries.first.value.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 70.0),
                          child: Divider(thickness: 1, height: 1,),
                        )
                      ],
                    ),
              ),
            ),

            if(isLogin)
              TextButton(
                onPressed: () => null,
                child: Text("logout".tr),
                style: TextButton.styleFrom(
                  primary: AppColors.skyBlue,
                textStyle: TextStyle(decoration: TextDecoration.underline, fontSize: SizeConfig.textMultiplier * 1.8),
              ),
            ),
            // VerticalSpace(10)
          ],
        )
    );
  }

  handleClick(String item) {
    switch (item) {
      case 'more_info':
        Get.toNamed(AppRoutes.INFO, arguments: spot);
        Get.back(closeOverlays: true);
        break;
      case "login_signup":
        Get.back(closeOverlays: true);
        Get.dialog(DialogComponent(), barrierDismissible: true, useSafeArea: true);
        break;
      case "favorites":
        Get.back(closeOverlays: true);
        Get.toNamed(AppRoutes.FAVORITES, id: 1);
        break;
    }
  }
}
