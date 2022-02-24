import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/navigation_controller.dart';
import 'package:vyv/screens/home.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';

class BottomNavigation extends StatelessWidget {
  NavigationController controller = Get.put(NavigationController());

  final TextStyle unselectedLabelStyle = TextStyle(color: AppColors.lightGrey, fontSize: 12);

  List<String> pages = ["Home", "Calendar", "Guides", "Events"];
  final TextStyle selectedLabelStyle = TextStyle(color: AppColors.lightGrey, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: buildBottomNavigationMenu(context, controller),
          body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              HomeScreen(),
              Container(color: Colors.red,),
              Container(color: Colors.blue,),
              Container(color: Colors.amberAccent),
            ],
          )),
        ));
  }

  Widget buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
        child: SizedBox(
          height: SizeConfig.heightMultiplier * 8,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex.value,
            backgroundColor: AppColors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            selectedItemColor: AppColors.lightGrey,
            unselectedItemColor: AppColors.lightGrey,
            items: List.generate(pages.length, (index) => BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.darkGrey))),
                // margin: EdgeInsets.only(bottom: 7),
                child: SvgPicture.asset(
                    index == 0 ? "assets/images/svgs/house.svg" :
                    index == 1 ? "assets/images/svgs/calender.svg" :
                    index == 2 ? "assets/images/svgs/guides.svg" :
                    "assets/images/svgs/hat.svg"
                ),
              ),
              label: pages.elementAt(index),
              backgroundColor: AppColors.white,
            ),
          ),
        ))));
  }
}
