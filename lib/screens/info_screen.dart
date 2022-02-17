import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyp/utils/app_colors.dart';
import 'package:vyp/utils/constants.dart';
import 'package:vyp/utils/size_config.dart';
import 'package:vyp/widgets/text_component.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

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
        leading: IconButton(onPressed: () => Get.back(), icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg")),
        actions: [],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),

      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://s3-alpha-sig.figma.com/img/14da/de7a/53bbc93c0f0cc06000d0f846d34c04c0?Expires=1646006400&Signature=haYuDjTnl8vAu5lazbNSuc~A8o~~jnwFbEczvtOrj~zyEjDGc5CBZDHaW973ZjI2SngwzZHRluTMdifPrIJRbSfQuG-NwaETa3JovwpS-L~CXWITow8nqUXMNcazEDV06xlecvqrpxn5VP4uhOGd61xhLMtINsstMHWguNkQmzdJxpjOkm5oYyDBfMJ1pVTGd-USYSDD-c~E-vsxn27orcqiThp42YiTYcJo-4qoidwhD0KZdT9tOtyEXY7yU~~cOLR0U~KpHadJuKJQ-DVwHeuRSjmuT0ArmGy1dGZrnIaMzXC-NiJM-gTl5x5P6ANxMgUcUfaVjQrpiTzbymCPsg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
              height: SizeConfig.heightMultiplier * 20,
              fit: BoxFit.cover,
            ),

            TextWidget(text: "Tennis de Monte Frio"),
            TextWidget(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vitae mollis ipsum. Integer at mi vel nisi sagittis aliquam... Read more "),
          ],
        ),
      ),
    );
  }
}
