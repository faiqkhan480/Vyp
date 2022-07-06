import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/widgets/text_component.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';
import 'info_sheet.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key}) : super(key: key);

  handleInfoClick() {
    Get.bottomSheet(
      InfoSheet(item: null,),
      isDismissible: true,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
      enableDrag: false,
    );
    // Get.toNamed(AppRoutes.INFO, id: 1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleInfoClick,
      child: Container(
        width: Get.width * .40,
        decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            image: AssetImage(Constants.imgUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                BlendMode.colorBurn),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch  ,
          children: [
            TextWidget(
              text: "Paddel Tournament",
              size: 2.6,
              weight: FontWeight.w700,
              color: AppColors.white,
              // align: TextAlign.center,
            ),
            Spacer(),
            TextWidget(
              text: "Playing paddel in a free tournament. Bring your own ",
              size: 1.8,
              color: AppColors.white,
              // align: TextAlign.center,
            ),
            Spacer(),
            Row(
              children: [
                SvgPicture.asset("assets/images/svgs/location.svg", color: AppColors.primaryColor,),
                SizedBox(width: 10,),
                TextWidget(
                  text: "Lisboa",
                  size: 1.8,
                  weight: FontWeight.w700,
                  color: AppColors.white,
                  // align: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SvgPicture.asset("assets/images/svgs/calender.svg", color: AppColors.primaryColor,),
                SizedBox(width: 10,),
                TextWidget(
                  text: "26 May - 30 Aug ",
                  size: 1.8,
                  weight: FontWeight.w700,
                  color: AppColors.white,
                  // align: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
