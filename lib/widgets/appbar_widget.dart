import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';

import 'text_component.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  const AppBarWidget({Key? key, this.child}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      actions: [child ?? SizedBox() ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }
}
