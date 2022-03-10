import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/utils/app_colors.dart';

class Constants {
  static final baseURL = 'vyvapi.azurewebsites.net';
  static final appName = 'Vyv';
  static final imgUrl = 'assets/images/svgs/national-stadium-karachi-E-03-07-1.jpg';
  static final appbarHeight = AppBar().preferredSize.height;
}

List<Map<String, dynamic>> guestMenu = [
  {
    "label" : "login_signup",
    "icon" : SvgPicture.asset("assets/images/svgs/card.svg"),
  },
  {
    "label" : "settings",
    "icon" : SvgPicture.asset("assets/images/svgs/gear.svg"),
  }
];

List<Map<String, dynamic>> loginMenu = [
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



List<Map<String, dynamic>> itemMenu = [
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
