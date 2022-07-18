import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../components/map_box.dart';
import '../../components/plan_tile.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/text_component.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBarWidget(rootId: 2),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // PLAN TITLE
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: TextWidget(
            text: "PLAN: LISBON TENNIS",
            size: 2.5,
            // align: TextAlign.center,
            weight: FontWeight.w300,
          ),
        ),

        // DAYS TABS
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.greyScale))
          ),
          child: TabBar(
              indicatorColor: AppColors.black,
              // indicator: BoxDecoration( color: AppColors.grey),
              indicatorWeight: 2.0,
              labelColor: AppColors.black,
              labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: SizeConfig.textMultiplier * 2.0),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: SizeConfig.textMultiplier * 1.8),
              labelPadding: EdgeInsets.zero,
              isScrollable: true,
              // onTap: controller.changeTab,
              tabs: List.generate(3, (index) => Tab(child:  Container(
                decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: AppColors.black, width: 0.1))),
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 5),
                height: double.infinity,
                width: 100,
                child: Text(
                  "Day ${++index}",
                  textAlign: TextAlign.center,
                ),
              ),))
          ),
        ),

        // SizedBox(height: 10,),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyScale)
          ),
          margin: EdgeInsets.symmetric(vertical: 15),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: "Day1",
                weight: FontWeight.w700,
                size: 2,
              ),
              SvgPicture.asset("assets/images/svgs/archive.svg")
            ],
          ),
        ),

        Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...List.generate(3, (index) => PlanTile(
                    onPressed: () => null,
                    bottomBorder: index < 2
                )),

                Divider(thickness: 1,),

                SizedBox(
                    height: Get.height * 0.40,
                    child: MapBox())
              ],
            ),
          ),
        )
      ],
    );
  }
}
