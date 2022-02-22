import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

import 'info_sheet.dart';

class MenuSheet extends StatelessWidget {
  const MenuSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List menu = loginMenu;
    return Container(
        color: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(vertical: 20),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              children: List.generate(
                menu.length,
                    (index) => ListTile(
                      leading: menu.elementAt(index).entries.last.value,
                      title: TextWidget(
                        text: menu.elementAt(index).entries.first.value.toString(),
                        size: 1.8,
                      ),
                      subtitle: Divider(thickness: 1, height: 1,),
                      dense: true,
                      minVerticalPadding: 0.0,
                      onTap: () => handleClick(index),
                    ),
              ),
            ),
            TextButton(
                onPressed: () => null,
                child: Text("logout"),
                style: TextButton.styleFrom(
                  primary: AppColors.skyBlue,
                textStyle: TextStyle(decoration: TextDecoration.underline, fontSize: SizeConfig.textMultiplier * 1.8),
              ),
            ),
            VerticalSpace(20)
          ],
        )
    );
  }

  handleClick(index) {
    switch (index) {
      case 0:
        Get.bottomSheet(
          InfoSheet(),
          isDismissible: true,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          enableDrag: false,
        );
        break;
      case 1:
        Get.back(closeOverlays: true);
        Get.toNamed("/fav");
        break;
    }
  }
}
