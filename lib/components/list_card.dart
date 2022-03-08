import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';
import 'package:get/get.dart';

import 'info_sheet.dart';
import 'menu_sheet.dart';

class ListCard extends StatelessWidget {
  final num? index; final Spot? item;
  const ListCard({Key? key, this.index, this.item}) : super(key: key);

  handleClick() {
    Get.bottomSheet(
      MenuSheet(isLogin: true,),
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
    return Container(
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
          TextWidget(text: item?.spotName ?? "", color: AppColors.white, weight: FontWeight.w300, ),
          VerticalSpace(20),
          TextWidget(text: item?.spotName ?? "", size: 1.7, color: AppColors.white, align: TextAlign.center,),
          VerticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(child: SvgPicture.asset("assets/images/svgs/info.svg"), onTap: handleInfoClick,),
              InkWell(child: SvgPicture.asset("assets/images/svgs/vertical_circles.svg"), onTap:handleClick,),
            ],
          )
        ],
      ),
    );
  }
}