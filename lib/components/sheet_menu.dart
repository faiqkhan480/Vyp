import 'package:flutter/material.dart';
import 'package:vyp/utils/app_colors.dart';
import 'package:vyp/utils/constants.dart';
import 'package:vyp/utils/size_config.dart';
import 'package:vyp/widgets/space.dart';
import 'package:vyp/widgets/text_component.dart';

class SheetMenu extends StatelessWidget {
  const SheetMenu({Key? key}) : super(key: key);

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
}
