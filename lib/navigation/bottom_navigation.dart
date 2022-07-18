import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/root_controller.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/screens/calender_screen.dart';
import 'package:vyv/screens/guides_screen.dart';
import 'package:vyv/screens/info/info_binding.dart';
import 'package:vyv/screens/info/info_screen.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/text_component.dart';

class BottomNavigation extends GetView<RootController> {

  final TextStyle unselectedLabelStyle = TextStyle(color: AppColors.lightGrey, fontSize: 12);

  List<String> pages = ["Home", "Calendar", "Guides", "Events"];
  final TextStyle selectedLabelStyle = TextStyle(color: AppColors.lightGrey, fontSize: 12);

  Future<bool> onWilPop() async {
    print("onWilPop:::::");
    final isFirstRouteInCurrentTab = !await Get.nestedKey(1)!.currentState!.maybePop();
    print(isFirstRouteInCurrentTab);
    if (isFirstRouteInCurrentTab) {
      if (controller.currentIndex() != 0) {
        controller.changeTab(0);
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Navigator(
          key: Get.nestedKey(1), // create a key by index
          onGenerateRoute: controller.homeRoutes,
          ),
      Navigator(
          key: Get.nestedKey(2), // create a key by index
          onGenerateRoute: controller.calenderRoutes,
        // onGenerateRoute: (settings) {
          //   return GetPageRoute(page: () => CalenderScreen());
          // }
          ),
      Navigator(
          key: Get.nestedKey(3), // create a key by index
          onGenerateRoute: (settings) {
            return GetPageRoute(page: () => GuidesListing(title: "Guides",));
          }),
      Navigator(
          key: Get.nestedKey(4), // create a key by index
          onGenerateRoute: (settings) {
            return GetPageRoute(page: () => GuidesListing(title: "Events",));
          }),
    ];
    return WillPopScope(
      onWillPop: onWilPop,
      child: Scaffold(
        body: Obx(() => IndexedStack(
          index: controller.currentTab.value,
          children: _pages,
        )),
        bottomNavigationBar: BottomAppBar(
          elevation: 4.0,
          color: AppColors.white,
          child: SizedBox(
            // height: Get.height * 0.10,
            height: 70,
            width: double.infinity,
            // padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) => Expanded(
                child: InkWell(
                  onTap: () => controller.changeTab(index),
                  borderRadius: BorderRadius.circular(100),
                  child: Obx(() => Container(
                    decoration: controller.currentTab.value == index ? BoxDecoration(border: Border(top: BorderSide(color: Colors.black))) : BoxDecoration(),
                    padding: EdgeInsets.only(top: 10, bottom: 8),
                    child: Ink(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                              index == 0 ? "assets/images/svgs/house.svg" :
                              index == 1 ? "assets/images/svgs/calender.svg" :
                              index == 2 ? "assets/images/svgs/guides.svg" :
                              "assets/images/svgs/hat.svg"
                          ),
                          TextWidget(text: pages[index], align: TextAlign.center,)
                        ],
                      ),
                    ),
                  )),
                ),
              ),),
            ),
          ),
        ),
        // body: Obx(() => IndexedStack(
        //   index: controller.tabIndex.value,
        //   children: [
        //     HomeScreen(),
        //     Container(color: Colors.red,),
        //     Container(color: Colors.blue,),
        //     Container(color: Colors.amberAccent),
        //   ],
        // )),
      ),
    );
  }

  Widget buildBottomNavigationMenu(context) {
    return BottomAppBar(
      elevation: 4.0,
      color: AppColors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) => InkWell(
            onTap: () => controller.changePage(index),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                      index == 0 ? "assets/images/svgs/house.svg" :
                      index == 1 ? "assets/images/svgs/calender.svg" :
                      index == 2 ? "assets/images/svgs/guides.svg" :
                      "assets/images/svgs/hat.svg"
                  ),
                  TextWidget(text: pages[index])
                ],
              ),
            ),
          ),),
        ),
      ),
    );
  }
}

