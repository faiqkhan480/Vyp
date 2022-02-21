import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyp/utils/app_colors.dart';

class Constants {
  static final baseURL = 'https://vyvapi.azurewebsites.net';
  static final appName = 'Vyv';
  static final imgUrl = 'https://s3-alpha-sig.figma.com/img/14da/de7a/53bbc93c0f0cc06000d0f846d34c04c0?Expires=1646006400&Signature=haYuDjTnl8vAu5lazbNSuc~A8o~~jnwFbEczvtOrj~zyEjDGc5CBZDHaW973ZjI2SngwzZHRluTMdifPrIJRbSfQuG-NwaETa3JovwpS-L~CXWITow8nqUXMNcazEDV06xlecvqrpxn5VP4uhOGd61xhLMtINsstMHWguNkQmzdJxpjOkm5oYyDBfMJ1pVTGd-USYSDD-c~E-vsxn27orcqiThp42YiTYcJo-4qoidwhD0KZdT9tOtyEXY7yU~~cOLR0U~KpHadJuKJQ-DVwHeuRSjmuT0ArmGy1dGZrnIaMzXC-NiJM-gTl5x5P6ANxMgUcUfaVjQrpiTzbymCPsg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA';
  static final appbarHeight = AppBar().preferredSize.height;
}

List<Map<String, dynamic>> guestMenu = [
  {
    "label" : "login_signup",
    "icon" : SvgPicture.asset("assets/images/svgs/card.svg"),
  },
  {
    "label" : "account",
    "icon" : SvgPicture.asset("assets/images/svgs/person.svg"),
  },
  {
    "label" : "favorites",
    "icon" : SvgPicture.asset("assets/images/svgs/mark.svg"),
  },
  {
    "label" : "settings",
    "icon" : SvgPicture.asset("assets/images/svgs/gear.svg"),
  }
];

List<Map<String, dynamic>> loginMenu = [
  {
    "label" : "more_info",
    "icon" : SvgPicture.asset("assets/images/svgs/info.svg", color: AppColors.darkGrey,),
  },
  {
    "label" : "add_fav",
    "icon" : SvgPicture.asset("assets/images/svgs/mark.svg"),
  },
  {
    "label" : "add_calender",
    "icon" : SvgPicture.asset("assets/images/svgs/archive.svg"),
  },
  {
    "label" : "share",
    "icon" : SvgPicture.asset("assets/images/svgs/share.svg"),
  }
];
