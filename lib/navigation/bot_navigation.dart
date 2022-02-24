import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/text_component.dart';

import 'tab_navigator.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentPage = 0;
  List<String> pageKeys = ["Home", "Calendar", "Guides", "Events"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Calendar": GlobalKey<NavigatorState>(),
    "Guides": GlobalKey<NavigatorState>(),
    "Events": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == pageKeys[_currentPage]) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = index;
      });
    }
  }

//toLoginBack not used
  toLoginBack() {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  toHome(){
    _selectTab('Home', 0);
  }

  Future<bool> onWilPop(home) async {
    print("onWilPop:::::");
    final isFirstRouteInCurrentTab = !await _navigatorKeys[pageKeys[_currentPage]]!.currentState!.maybePop();
    print(isFirstRouteInCurrentTab);
    if (isFirstRouteInCurrentTab) {
      if (_currentPage != 0) {
        _selectTab('Home', 0);
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,// transparent status bar
        statusBarIconBrightness: Brightness.dark
    ));
    bool s = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () => onWilPop(false),
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator("Home"),
            _buildOffstageNavigator("StudyGuide"),
            _buildOffstageNavigator("Notifications"),
            _buildOffstageNavigator("Profile"),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 4.0,
          color: AppColors.white,
          child: Container(
            height: SizeConfig.heightMultiplier * 8,
            width: double.infinity,
            // color: Constants.primaryColor,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) => InkWell(
                onTap: () {
                  _selectTab("Home", 0);
                },
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
                      TextWidget(text: pageKeys[index])
                    ],
                  ),
                ),
              ),),
              // children: [
              //   InkWell(
              //     onTap: () {
              //       _selectTab("Home", 0);
              //     },
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         SvgPicture.asset("assets/images/svgs/house.svg"),
              //         TextWidget(text: "home")
              //       ],
              //     ),
              //   ),
              //   InkWell(
              //     onPressed: () {
              //       _selectTab("StudyGuide", 1);
              //     },
              //     icon: SvgPicture.asset("assets/images/svgs/calender.svg"),
              //   ),
              //   InkWell(
              //     onPressed: () {
              //       _selectTab("Notifications", 2);
              //     },
              //     icon: SvgPicture.asset("assets/images/svgs/guides.svg"),
              //   ),
              //   InkWell(
              //     onPressed: () {
              //       _selectTab("Profile", 3);
              //     },
              //     icon: SvgPicture.asset("assets/images/svgs/hat.svg"),
              //   ),
              // ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: pageKeys[_currentPage] != tabItem,
      child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          tabItem: tabItem,
          onBack: toHome,
          loginBack: toLoginBack
      ),
    );
  }
}
