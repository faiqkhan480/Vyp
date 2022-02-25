import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/navigation_controller.dart';
import 'package:vyv/controllers/root_controller.dart';
import 'package:vyv/routes/app_routes.dart';
import 'package:vyv/screens/home.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/text_component.dart';

class BottomNavigation extends GetView<RootController> {

  final TextStyle unselectedLabelStyle = TextStyle(color: AppColors.lightGrey, fontSize: 12);

  List<String> pages = ["Home", "Calendar", "Guides", "Events"];
  final TextStyle selectedLabelStyle = TextStyle(color: AppColors.lightGrey, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: buildBottomNavigationMenu(context, controller),
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: AppRoutes.HOME,
        onGenerateRoute: controller.onGenerateRoute,
      ),

      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          selectedItemColor: Colors.pink,
          onTap: controller.changePage,
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
    );
  }

  Widget buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
      data: MediaQuery.of(context).copyWith(size: Size(double.infinity, SizeConfig.heightMultiplier * 8)),
      child: BottomAppBar(
        elevation: 4.0,
        color: AppColors.white,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) => InkWell(
              onTap: () => landingPageController.changeTabIndex(index),
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
      ),
    ));
  }
}
