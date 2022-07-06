import 'dart:io';

import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/constants.dart';
import 'package:vyv/widgets/text_component.dart';

// List<String> _days = ["W", "T", "F", "S", "S", "M", "T"];

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  List get days => DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONENARROWWEEKDAYS;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          title: TextWidget(
            text: DateFormat("MMM yyyy").format(DateTime.now()),
            color: AppColors.white,
            size: 3,
            align: TextAlign.center,
            weight: FontWeight.bold,
            // family: 'GemunuLibre',
          ),
          actions: [
            IconButton(
                onPressed: () => null,
                icon: SvgPicture.asset("assets/images/svgs/calender.svg", color: AppColors.white,)
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 80),
            child: Column(
              children: [
                Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(days.length, (index) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(
                            text: days.elementAt(index),
                            color: AppColors.white,
                            align: TextAlign.center,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),),
                    ),
          ),
                ColoredBox(
                  color: AppColors.white,
                  child: TabBar(
                    labelColor: AppColors.primaryColor,
                      labelStyle: TextStyle(fontFamily: "GemunuLibre", fontSize: 30, fontWeight: FontWeight.w600),
                      // indicatorColor: AppColors.primaryColor,
                      tabs: List.generate(7, (index) => Tab(
                        text: (index+1).toString(),
                      ))
                  ),
                )
              ],
            ),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(30),
          //   ),
          ),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => (index == 0) ? Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            text: "3:30 PM",
                            size: 2 ,
                            weight: FontWeight.w700,
                            color: AppColors.primaryColor,
                            align: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextWidget(
                            text: "\tPlaying with friends",
                            size: 2 ,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            text: "1h 00m",
                            size: 1.4 ,
                            align: TextAlign.center,
                            // weight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextWidget(
                            text: "\tTenis de Aigra Nova",
                            size: 1.8 ,
                            // weight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 1,),
                    // SizedBox(height: 10,)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            text: "3:30 PM",
                            size: 2 ,
                            weight: FontWeight.w700,
                            color: AppColors.primaryColor,
                            align: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextWidget(
                            text: "\tPlaying with friends",
                            size: 2 ,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            text: "1h 00m",
                            size: 1.4 ,
                            align: TextAlign.center,
                            // weight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextWidget(
                            text: "\tTenis de Aigra Nova",
                            size: 1.8 ,
                            // weight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 1,),
                    // SizedBox(height: 10,)
                  ],
                ),
              ),
            ],
          ) : Container(
            alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextWidget(
              text: "Nothing scheduled",
              size: 1.4,
            ),
          ),
          separatorBuilder: (context, index) => Container(
            // height: 40,
            // alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: AppColors.secondaryColor,
            child: TextWidget(
              text: "Wednesday, June 1",
              size: 1.8,
              weight: FontWeight.bold,
            ),
          ),
          itemCount: 3,
        ),
      ),
    );
  }
}
