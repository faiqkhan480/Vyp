import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/utils/app_colors.dart';

class Constants {
  static final baseURL = 'vyvapi.azurewebsites.net';
  static final appName = 'IViv';
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
  },
  {
    "label" : "reset_password",
    "icon" : Icon(Icons.lock_reset_rounded, color: AppColors.darkGrey,)
  },
];



List<Map<String, dynamic>> itemMenu = [
  {
    "label": "share_this",
    "icon": SvgPicture.asset("assets/images/svgs/share.svg", color: AppColors.grey,),
  },
  {
    "label" : "add_calender",
    "icon" : SvgPicture.asset("assets/images/svgs/add_calander.svg", color: AppColors.grey,),

  },
  {
    "label" : "add_fav",
    "icon" : SvgPicture.asset("assets/images/svgs/mark.svg", color: AppColors.grey,),
  },
  {
    "label" : "see_on_map",
    "icon" : SvgPicture.asset("assets/images/svgs/paper_map.svg", color: AppColors.grey,),
  },
  {
    "label" : "more_info",
    "icon" : SvgPicture.asset("assets/images/svgs/info.svg", color: AppColors.grey,),
  },
  {
    "label" : "reviews",
    "icon" : SvgPicture.asset("assets/images/svgs/star.svg", color: AppColors.grey,),
    "route": AppRoutes.REVIEWS,
  },
];

class StyleProperties {
  static prefixField({String? label, required String iconPath, double? prefixWidth}) => InputDecoration(
      isDense: true,
      counter: SizedBox(),
      prefixIconConstraints: BoxConstraints(maxWidth: prefixWidth ?? 40),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10),
        child: SvgPicture.asset(iconPath),
      ),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.black, width: 2)),
      contentPadding: EdgeInsets.zero,
      alignLabelWithHint: true,
      labelText: label,
      labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
  );

  static inputDecoration({String? label}) => InputDecoration(
      contentPadding: EdgeInsets.zero,
      counter: SizedBox(),
      alignLabelWithHint: true,
      labelText: label,
      labelStyle: TextStyle(color: AppColors.lightGrey, fontFamily: 'Heebo', fontWeight: FontWeight.w300)
  );
}
