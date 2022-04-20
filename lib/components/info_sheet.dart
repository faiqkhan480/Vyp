import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class InfoSheet extends StatelessWidget {
  final Spot? item;
  const InfoSheet({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<HomeController>().fetchData(item?.id ?? 0),
        builder: (context, AsyncSnapshot<Spot> snapshot) {
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
                        child: (snapshot.connectionState == ConnectionState.waiting) ?
                        SizedBox(width: 80, height: SizeConfig.heightMultiplier * 20,) :
                        Image.asset(
                          "assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg",
                          width: 80,
                          height: SizeConfig.heightMultiplier * 20,
                          fit: BoxFit.cover,
                        ),
                        // Image.network(
                        //   snapshot.data?.imageStr ?? "",
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
                              // TITLE ROW
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
                              // DISTRICT / COUNTRY ROW
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                 SvgPicture.asset("assets/images/svgs/pin.svg", height: SizeConfig.heightMultiplier * 1.8, color: AppColors.grey,),
                                  HorizontalSpace(8),
                                  TextWidget(
                                    text: "${Get.find<SearchController>().counties.firstWhere((c) => c.id == item!.idCounty).name}"
                                        ", ${Get.find<SearchController>().districts.firstWhere((d) => d.id == item!.idDistrict).name}",
                                    // color: AppColors.primaryColor,
                                    size: 1.8,
                                    weight: FontWeight.w300,
                                    // align: TextAlign.center,
                                  ),
                                ],
                              ),
                              VerticalSpace(5),
                              if(snapshot.connectionState == ConnectionState.waiting)
                                Center(child: CircularProgressIndicator())
                              else
                                TextWidget(text: snapshot.data?.shortDescription ?? "", size: 1.6, align: TextAlign.justify, weight: FontWeight.w300,),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                // OPTIONS ROW
                if(snapshot.connectionState != ConnectionState.waiting)
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(icon: SvgPicture.asset("assets/images/svgs/share.svg", color: AppColors.grey,), onPressed: () => handleShare(snapshot.data!),),
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
    );
  }

  handleShare(Spot spotData) {
    Share.share(
        "${spotData.spotName!}\n"
            "${Get.find<SearchController>().districts.firstWhere((d) => d.id == spotData.idDistrict).name}"
            "\\${Get.find<HomeController>().selectedCountry.value.countryName}\n"
            "${spotData.shortDescription!}\n "
            "${spotData.website}"
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
