import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';

import 'list_card.dart';

class CountryList extends StatelessWidget {
  final List<Spot>? spots;
  const CountryList({Key? key, this.spots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if(spots!.isEmpty)
    //   return SizedBox();
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.heightMultiplier * 50,
        // child: PagedGridView(
        //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //       maxCrossAxisExtent: 250,
        //       childAspectRatio: 1.0,
        //       crossAxisSpacing: 6,
        //       mainAxisSpacing: 6),
        //   scrollDirection: Axis.horizontal,
        //   pagingController: Get.find<HomeController>().pagingController,
        //   builderDelegate: PagedChildBuilderDelegate(
        //       itemBuilder: (context, item, index) => ListCard(index: index, item: item as Spot)
        //   ),
        // ),
        child: Obx(() {
          return Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              LazyLoadScrollView(
                scrollDirection: Axis.horizontal,
                onEndOfPage: () => Get.find<HomeController>().handleSearch(),
                scrollOffset: 100,
                isLoading: Get.find<HomeController>().loading(),
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: spots?.length,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 175,
                      maxCrossAxisExtent: 250,
                      // childAspectRatio: 2.0,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6),
                  itemBuilder: (context, index) => ListCard(index: index, item: spots?.elementAt(index),),
                ),
              ),

              if(Get.find<HomeController>().loading())
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(20.0),
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator())
            ],
          );
        }),
      ),
    );
  }
}
