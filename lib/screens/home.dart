import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyv/components/country_list.dart';
import 'package:vyv/components/group_list.dart';
import 'package:vyv/utils/app_colors.dart';

import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/input_field.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<String> tabs = ["Portugal", "districts", "counties"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        title: TextWidget(
          text: Constants.appName,
          color: AppColors.primaryColor,
          size: 5,
          align: TextAlign.center,
          family: 'GemunuLibre',
        ),
        actions: [IconButton(onPressed: () => null, icon: Icon(Icons.menu, color: Colors.black,))],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/svgs/pin.svg", height: SizeConfig.heightMultiplier * 1.8,),
              HorizontalSpace(8),
              TextWidget(
                text: "lisbon",
                // color: AppColors.primaryColor,
                size: 1.8,
                // align: TextAlign.center,
              ),
            ],
          ),),
          preferredSize: Size(double.infinity, 30),
        ),
      ),

      body: DefaultTabController(
        length: tabs.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              placeHolder: "what_r_u_looking_for",
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/images/svgs/rocket.svg"),
              ),
              horizontal: 30,
              vertical: 20,
            ),
            // VerticalSpace(15),
            InputField(
              placeHolder: "where",
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/images/svgs/location.svg"),
              ),
              horizontal: 30,
              vertical: 0,
            ),
            VerticalSpace(20),
            TabBar(
                indicatorColor: AppColors.black,
                indicatorWeight: 0.9,
                labelPadding: EdgeInsets.zero,
                tabs: List.generate(tabs.length, (index) => Tab(child:  Container(
                  decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: AppColors.black, width: 0.1))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 5),
                  height: double.infinity,
                  width: double.infinity,
                  child: TextWidget(
                    text: tabs.elementAt(index),
                    size: 1.8,
                    align: TextAlign.center,
                  ),
                ),))
            ),

            // CountryList(),
            Flexible(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CountryList(),
                    GroupList(),
                    GroupList(),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
