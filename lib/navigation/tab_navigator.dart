import 'package:flutter/material.dart';
import 'package:vyp/screens/home.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.onBack, this.loginBack});
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;
  final onBack, loginBack;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (tabItem == "Home") {
      child = HomeScreen();
    } else if (tabItem == "Calendar") {
      child = HomeScreen();
    } else if (tabItem == "Guides") {
      child = HomeScreen();
    }
    else {
      child = HomeScreen();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child!);
      },
    );
  }
}
