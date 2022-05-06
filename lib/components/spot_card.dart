import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/text_component.dart';
import 'package:get/get.dart';

import 'info_sheet.dart';
import 'menu_sheet.dart';

class SpotCard extends StatelessWidget {
  final num? index;
  final Spot? item;
  final bool isLast;
  const SpotCard({Key? key, this.index, this.item, this.isLast = false}) : super(key: key);

  handleClick() {
    Get.bottomSheet(
      MenuSheet(isLogin: false, isItemMenu: true, spot: item,),
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

  handleInfoClick() {
    Get.bottomSheet(
      InfoSheet(item: item,),
      isDismissible: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
      enableDrag: false,
    );
    // Get.toNamed(AppRoutes.INFO, id: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: handleInfoClick,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Constants.imgUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                      BlendMode.colorBurn),
                ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            // height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTapDown: (TapDownDetails details) async {
                    await showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(details.globalPosition.dx, details.globalPosition.dy, details.globalPosition.dx, details.globalPosition.dy),
                      items: List.generate(item!.category!.length, (index) => PopupMenuItem(child: Text(item!.category?.elementAt(index)))),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: SizeConfig.textMultiplier * 1.8 ),
                        text: item!.category?.elementAt(0) ?? "",
                        children: [
                          if(item!.category!.length > 1)
                            TextSpan(text: " +" + (item!.category!.length - 1).toString())
                        ]
                    ),
                  ),
                ),
                // PopupMenuButton(
                //   child: RichText(
                //     text: TextSpan(
                //         style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: SizeConfig.textMultiplier * 1.8 ),
                //         text: item!.category?.elementAt(0) ?? "",
                //         children: [
                //           if(item!.category!.length > 1)
                //             TextSpan(text: " +" + (item!.category!.length - 1).toString() ?? "")
                //         ]
                //     ),
                //   ),
                //     itemBuilder: (context) => List.generate(item!.category!.length, (index) => PopupMenuItem(child: Text(item!.category?.elementAt(index)))),
                // ),
                Spacer(),
                TextWidget(text: item?.spotName ?? "", size: 2.0, color: AppColors.white, align: TextAlign.center,),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
        ),

        // Positioned(
        //   bottom: 0.0,
        //   left: 0,
        //   right: 0,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       // InkWell(child: SvgPicture.asset("assets/images/svgs/info.svg"), onTap: handleInfoClick,),
        //       // InkWell(child: SvgPicture.asset("assets/images/svgs/vertical_circles.svg"), onTap:handleClick,),
        //       IconButton(
        //         onPressed: handleInfoClick,
        //         icon: SvgPicture.asset("assets/images/svgs/info.svg"),
        //       ),
        //       IconButton(
        //         onPressed: handleClick,
        //         icon: SvgPicture.asset("assets/images/svgs/vertical_circles.svg"),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}