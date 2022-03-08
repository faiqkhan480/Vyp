import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool readMore = false;

  HomeController controller = Get.find<HomeController>();
  void handleState() {
    this.setState(() {
      readMore = !readMore;
    });
  }

  Spot? spot = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: TextWidget(
          text: Constants.appName,
          color: AppColors.primaryColor,
          size: 5,
          align: TextAlign.center,
          family: 'GemunuLibre',
        ),
        leading: IconButton(onPressed: () => Get.back(canPop: true, id: 1), icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg")),
        actions: [],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),

      body: Container(
        child: ListView(
          children: [
            // BANNER IMAGE
            Image.network(
              spot?.imageStr ?? "",
              // Constants.imgUrl,
              height: SizeConfig.heightMultiplier * 20,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => SizedBox(height: 100, child: Icon(Icons.broken_image_rounded, color: AppColors.grey, size: 60,)),
            ),

            // CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextWidget(
                    text: spot?.spotName ?? "",
                    size: 2.4,
                    weight: FontWeight.w700,
                  ),
                  VerticalSpace(20),

                  AnimatedContainer(
                    // height: readMore ? 100.0 : 200.0,
                    // height: 50.0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: Row(
                      children: [
                        // Text(
                        //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        //   style: TextStyle(
                        //       fontFamily: "Heebo",
                        //       fontSize: SizeConfig.textMultiplier * 1.8,
                        //       color: AppColors.black,
                        //   ),
                        //   maxLines: 5,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        Flexible(
                          child: RichText(
                            text: new TextSpan(
                                // text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                style: TextStyle(
                                    fontFamily: "Heebo",
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    color: AppColors.black
                                ),
                                children: [
                                  TextSpan(
                                    text: spot?.longDescription ?? "",
                                    style: TextStyle(
                                      // fontWeight: FontWeight.w700,
                                    ),

                                  ),
                                ]
                            ),
                            // maxLines: 5,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: handleState,
                        //   child: TextWidget(
                        //     text: 'Read more',
                        //     weight: FontWeight.w700,
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  ...List.generate(3, (index) => linksRow(
                    index == 0 ? "assets/images/svgs/link_move.svg" :
                    index == 1 ? "assets/images/svgs/phone.svg" :
                    "assets/images/svgs/email.svg",
                    index == 0 ? spot?.website ?? "" :
                    index == 1 ? spot?.contact ?? "" :
                    spot?.email ?? "",
                  )),

                  ...List.generate(3, (index) => TextWidget(text: index == 0 ? "categories" : index == 1 ? "tips" : "maps", weight: FontWeight.w700, size: 1.7,)),

                  VerticalSpace(10),

                  TextWidget(text: "reviews", weight: FontWeight.w700, size: 2.2,),

                  ...List.generate(5, (index) => progressRow(5.toString(), 456.toString())),

                  VerticalSpace(10),
                  usersStars()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget linksRow(String iconPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          HorizontalSpace(10),
          TextWidget(text: text, weight: FontWeight.w700, size: 1.6,),
        ],
      ),
    );
  }

  Widget progressRow(String stars, String points) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(Icons.star, color: AppColors.skyBlue,),
          HorizontalSpace(10),
          TextWidget(text: stars, size: 1.6,),
          Expanded(
              child: LinearPercentIndicator(
                width: SizeConfig.screenWidth * 0.74,
                lineHeight: 8.0,
                percent: 0.5,
                barRadius: Radius.circular(50),
                progressColor: AppColors.skyBlue,)
          ),
          // HorizontalSpace(10),
          TextWidget(text: points, size: 1.6,),
          // HorizontalSpace(10),
        ],
      ),
    );
  }

  Widget usersStars() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...List.generate(5, (index) => Icon(Icons.star, color: AppColors.skyBlue,),),
          TextWidget(text: "CharlieBillBlister", size: 2.0,),
          Spacer(),
          TextWidget(text: "Jan 12,2022", size: 2.0,),
        ],
      ),
    );
  }
}
