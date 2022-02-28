import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class InfoSheet extends StatelessWidget {
  const InfoSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor,
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: "Tennis de Aigra Nova", size: 2.2, color: AppColors.darkGrey,),
                InkWell(child: SvgPicture.asset("assets/images/svgs/close_square.svg"), onTap: handleClose,)
              ],
            ),
          ),
          // WEB LINK ROW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              children: [
                TextWidget(text: "free", size: 2.0, weight: FontWeight.w500,),
                HorizontalSpace(8),
                SvgPicture.asset("assets/images/svgs/success.svg"),
                HorizontalSpace(8),
                TextWidget(text: "go_to_web", size: 1.8, weight: FontWeight.w500,),
                HorizontalSpace(8),
                InkWell(child: SvgPicture.asset("assets/images/svgs/global.svg"), onTap: () => null,)
              ],
            ),
          ),
          // INFO CONTENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    Constants.imgUrl,
                    width: 80,
                    height: SizeConfig.heightMultiplier * 14,
                    fit: BoxFit.cover,
                  ),
                ),
                HorizontalSpace(8),
                Expanded(flex: 3,child: TextWidget(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vitae mollis ipsum. Integer at mi vel nisi sagittis aliquam."
                    " Integer fermentum sed quam non blandit. Vivamus dapibus commodo libero at sodales."
                    "Integer fermentum sed quam non blandit.", size: 1.6, align: TextAlign.justify, weight: FontWeight.w300,)),
              ],
            ),
          ),
          Divider(color: AppColors.grey,),
          ListTile(
            leading: SvgPicture.asset("assets/images/svgs/info.svg", color: AppColors.grey,),
            title: TextWidget(
              text: "more_info",
              size: 1.8,
            ),
            trailing: SvgPicture.asset("assets/images/svgs/arrow_forward.svg"),
            onTap: handleNavigate,
          ),
        ],
      ),
    );
  }

  handleClose() {
    Get.back();
  }

  handleNavigate() {
    Get.back(closeOverlays: true);
    Get.toNamed(AppRoutes.INFO, id: 1);
  }
}
