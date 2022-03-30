import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';

import 'spot_card.dart';

class HorizontalList extends StatelessWidget {
  final List<Spot>? spots;
  final bool? isCountry;
  final int? parentId;
  HorizontalList({Key? key, this.spots, this.isCountry = true, this.parentId}) : super(key: key);
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity,
        // // height: spots!.length < 3 ? SizeConfig.heightMultiplier * 22.5 : SizeConfig.heightMultiplier * 45,
        // // height: spots!.length < 3 ? Get.height * 0.21 : Get.height * 0.42,
        height: spots!.length < 3 ? 160 : 300,
        child: Obx(() {
          return Stack(
            children: [
              LazyLoadScrollView(
                scrollDirection: Axis.horizontal,
                onEndOfPage: () async {
                  if(isCountry!) {
                    Get.find<HomeController>().loadMore();
                  }
                  else {
                    var res = await Get.find<HomeController>().loadMore(pageKey: _page+1, id: parentId);
                    if(res != null)
                      _page = res;
                  }
                },
                scrollOffset: 100,
                isLoading: Get.find<HomeController>().loading(),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: spots!.length < 3 ? 1 : 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemCount: spots?.length ?? 0,
                  padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 0),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SpotCard(index: index, item: spots?.elementAt(index)),
                  // children: List.generate(spots?.length ?? 0, (index) => SpotCard(index: index, item: spots?.elementAt(index))),
                ),
              ),

              if(Get.find<HomeController>().loading())
                Positioned(
                  right: -10,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(20.0),
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator()),
                  ),
                )
            ],
          );
        }),
      ),
    );
  }
}
