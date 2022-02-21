import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';
import 'package:get/get.dart';

import 'menu_sheet.dart';

class ListCard extends StatelessWidget {
  final num? index;
  const ListCard({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://s3-alpha-sig.figma.com/img/14da/de7a/53bbc93c0f0cc06000d0f846d34c04c0?Expires=1646006400&Signature=haYuDjTnl8vAu5lazbNSuc~A8o~~jnwFbEczvtOrj~zyEjDGc5CBZDHaW973ZjI2SngwzZHRluTMdifPrIJRbSfQuG-NwaETa3JovwpS-L~CXWITow8nqUXMNcazEDV06xlecvqrpxn5VP4uhOGd61xhLMtINsstMHWguNkQmzdJxpjOkm5oYyDBfMJ1pVTGd-USYSDD-c~E-vsxn27orcqiThp42YiTYcJo-4qoidwhD0KZdT9tOtyEXY7yU~~cOLR0U~KpHadJuKJQ-DVwHeuRSjmuT0ArmGy1dGZrnIaMzXC-NiJM-gTl5x5P6ANxMgUcUfaVjQrpiTzbymCPsg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),
                BlendMode.colorBurn),
          ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      // height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(text: "$index tennis", color: AppColors.white, weight: FontWeight.w300, ),
          VerticalSpace(20),
          TextWidget(text: "Tennis\nde Aigra Nova", size: 1.7, color: AppColors.white, align: TextAlign.center,),
          VerticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(child: SvgPicture.asset("assets/images/svgs/info.svg")),
              InkWell(child: SvgPicture.asset("assets/images/svgs/vertical_circles.svg"), onTap:() => handleClick(),),
            ],
          )
        ],
      ),
    );
  }

  handleClick() {
    Get.bottomSheet(
      MenuSheet(),
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
}