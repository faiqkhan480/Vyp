import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class InfoSheet extends StatelessWidget {
  final Spot? item;
  const InfoSheet({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor,
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // INFO CONTENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg",
                    width: 80,
                    height: SizeConfig.heightMultiplier * 20,
                    fit: BoxFit.cover,
                  ),
                  // child: Image.network(
                  //   item?.imageStr ?? "",
                  //   width: 80,
                  //   height: SizeConfig.heightMultiplier * 14,
                  //   fit: BoxFit.cover,
                  //   errorBuilder: (context, error, stackTrace) => SizedBox(height: SizeConfig.heightMultiplier * 14, width: 80, child: Image.asset("assets/images/svgs/no_img.png")),
                  // ),
                ),
                HorizontalSpace(8),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(text: item?.spotName ?? "", size: 2.2, color: AppColors.darkGrey,),
                            InkWell(
                              onTap: handleClose,
                              child: SvgPicture.asset("assets/images/svgs/close_square.svg"),
                            )
                          ],
                        ),
                        TextWidget(text: item?.shortDescription ?? "", size: 1.6, align: TextAlign.justify, weight: FontWeight.w300,),
                      ],
                    )
                ),
              ],
            ),
          ),
          // OPTIONS ROW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: SvgPicture.asset("assets/images/svgs/share.svg", color: AppColors.grey,), onPressed: () => null,),
                IconButton(icon: SvgPicture.asset("assets/images/svgs/archive.svg", color: AppColors.grey,), onPressed: () => null,),
                IconButton(icon: SvgPicture.asset("assets/images/svgs/mark.svg", color: AppColors.grey,), onPressed: () => null,),
                IconButton(icon: SvgPicture.asset("assets/images/svgs/paper_map.svg", color: AppColors.grey,), onPressed: () => null,),
              ],
            ),
          ),
          Divider(color: AppColors.grey,),
          ListTile(
            leading: SvgPicture.asset("assets/images/svgs/info.svg", color: AppColors.grey,),
            title: TextWidget(
              text: "more_info",
              size: 2.0,
            ),
            trailing: SvgPicture.asset("assets/images/svgs/arrow_forward.svg"),
            onTap: handleNavigate,
          ),
        ],
      ),
    );
  }

  void handleClick() async {
    if (!await launch("https://" + (item?.website ?? ""))) Get.rawSnackbar(title: 'Could not launch ${item?.website}');
  }

  handleClose() =>  Get.back();

  handleNavigate() {
    Get.back(closeOverlays: true);
    Get.toNamed(AppRoutes.INFO, arguments: item, id: 1);
    // Get.toNamed(AppRoutes.INFO, arguments: item);
  }
}
