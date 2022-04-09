import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vyv/components/dialog_component.dart';
import 'package:vyv/components/setting_sheet.dart';
import 'package:vyv/controllers/favorite_controller.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

import 'add_favorite_dialog.dart';

class MenuSheet extends StatelessWidget {
  final bool isLogin;
  final bool isItemMenu;
  final Spot? spot;
  const MenuSheet({Key? key, required this.isLogin, this.isItemMenu = false, this.spot}) : super(key: key);

  openSettings() {
    Get.bottomSheet(
      SettingsSheet(controller: Get.find<HomeController>()),
      isDismissible: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        // side: BorderSide(
        //     width: 5,
        //     color: Colors.black
        // )
      ),
      enableDrag: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    List menu = isLogin ? loginMenu : isItemMenu ? itemMenu : guestMenu;
    return FutureBuilder<Spot>(
      future: Get.find<HomeController>().fetchData(spot?.id ?? 0),
      builder: (context, AsyncSnapshot<Spot> snapshot) {
        // if(snapshot.connectionState == ConnectionState.waiting)
        //   return Center(child: CircularProgressIndicator());
        // if(snapshot.hasError)
        //   return TextWidget(text: "No data were found!");
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
                        if(menu.elementAt(index).entries.first.value.toString() == "share")
                          if(snapshot.connectionState == ConnectionState.waiting)
                            Center(child: SizedBox(height: 10, width: 10,child: CircularProgressIndicator()))
                          else
                          ListTile(
                            leading: menu.elementAt(index).entries.last.value,
                            title: TextWidget(
                              text: menu.elementAt(index).entries.first.value.toString(),
                              size: 1.8,
                            ),
                            // subtitle: Divider(thickness: 1, height: 1,),
                            dense: true,
                            // contentPadding: EdgeInsets.only(top: 3, bottom: 5),
                            onTap: () => Share.share("${snapshot.data!.shortDescription!}\n ${snapshot.data!.website}"),
                          )
                        else
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
                    onPressed: Get.find<HomeController>().handleLogout,
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
      },
    );
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
                onPressed: Get.find<HomeController>().handleLogout,
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
        Get.toNamed(AppRoutes.INFO, arguments: spot, id: 1);
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
      case "account":
        Get.back(closeOverlays: true);
        Get.toNamed(AppRoutes.ACCOUNT, id: 1);
        break;
      case "add_fav":
        Get.back(closeOverlays: true);
        if(Get.find<HomeController>().user?.id != null)
        Get.dialog(AddFavorite(controller: Get.put<FavoriteController>(FavoriteController(isFetching: false)), spot: spot,), barrierDismissible: true, useSafeArea: true)
            .then((value) => Get.delete<FavoriteController>());
        else
          Get.dialog(DialogComponent(), barrierDismissible: true, useSafeArea: true);
        break;
      case "settings":
        openSettings();
        break;
      case "share":
        Share.share('check out my website https://example.com');
        break;
    }
  }
}
