import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vyv/components/horizontal_list.dart';
import 'package:vyv/components/group_list.dart';
import 'package:vyv/components/spot_card.dart';
import 'package:vyv/components/map_box.dart';
import 'package:vyv/components/menu_sheet.dart';
import 'package:vyv/components/search_sheet.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/sub_category_model.dart';
import 'package:vyv/utils/app_colors.dart';

import 'package:vyv/utils/constants.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/input_field.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  List<String> tabs = ["Portugal", "districts", "counties"];

  handleClick() {
    Get.bottomSheet(
      MenuSheet(isLogin: controller.user!.id != null,),
      isDismissible: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        // side: BorderSide(
        //     width: 5,
        //     color: Colors.black
        // )
      ),
      enableDrag: false,
    );
  }

  // SEARCH SHEET
  handleSearch(bool isCategory) {
    Get.bottomSheet(
      SearchBottomSheet(isCategory),
      isDismissible: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
      enableDrag: false,
      isScrollControlled: true,
      persistent: true,
    ).then((value) {
      // Get.find<SearchController>().selectedDistricts.clear();
      // Get.find<SearchController>().selectedItems.clear();
    });
    // Get.toNamed(AppRoutes.INFO, id: 1);
  }

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
        actions: [IconButton(onPressed: handleClick, icon: Icon(Icons.menu, color: Colors.black,))],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        flexibleSpace: PreferredSize(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() => InkWell(
              onTap: controller.handleLocation,
              child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(controller.placeMarks.isNotEmpty)
                        SvgPicture.asset("assets/images/svgs/pin.svg", height: SizeConfig.heightMultiplier * 1.8,),
                      HorizontalSpace(8),
                      TextWidget(
                        text: controller.placeMarks.isNotEmpty ? "${controller.placeMarks.first.administrativeArea} ${controller.placeMarks.first.country}" : "",
                        // color: AppColors.primaryColor,
                        size: 1.8,
                        // align: TextAlign.center,
                      ),
                    ],
                  )
              ),
            )),
          ),
          preferredSize: Size(double.infinity, 18),
        ),
      ),
      body: Obx(body),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(mapButton),
    );
  }

  // BODY
  Widget body() {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...searchFields(),
          VerticalSpace(20),
          if(!controller.showMap.value)...[
            // TABS
            homeTabs(),
            // COUNTRY LIST,
            tabViews(),
          ]
          else
            MapBox(),
        ],
      ),
    );
  }

  // SEARCH FIELDS
  List<Widget> searchFields() {
    List categories = Get.find<SearchController>().selectedItems.where((e) => e is Category || e is SubCategory).toList();
    List districts = Get.find<SearchController>().selectedItems.where((e) => e is District || e is County).toList();
    return [
      InkWell(
        onTap: () => handleSearch(true),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5.0)
              ),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0,),
              padding: EdgeInsets.fromLTRB(34, 0, 0, 0),
              width: double.infinity,
              height: 50,
              child: categories.isEmpty ?
              Align(
                alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextWidget(text: "what_r_u_looking_for", size: 2.0, color: AppColors.greyScale,),
                  )) :
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text( categories.elementAt(index)?.name,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),)
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 12,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset("assets/images/svgs/rocket.svg"),
              ),
            )
          ],
        ),
      ),
      InkWell(
        onTap: () => handleSearch(false),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5.0)
              ),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0,),
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              // alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              child: districts.isEmpty ?
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextWidget(text: "where", size: 2.0, color: AppColors.greyScale,),
                  )) :
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(districts.length, (index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Text( districts.elementAt(index)?.name,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),)
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 12,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset("assets/images/svgs/location.svg"),
              ),
            )
          ],
        ),
      ),

    ];
  }

  // TABS
  Widget homeTabs() {
    return SizedBox(
      height: Get.height * 0.07,
      child: TabBar(
          indicatorColor: AppColors.black,
          indicatorWeight: 0.9,
          labelColor: AppColors.black,
          labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: SizeConfig.textMultiplier * 2.0),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: SizeConfig.textMultiplier * 1.8),
          labelPadding: EdgeInsets.zero,
          onTap: controller.changeTab,
          tabs: List.generate(tabs.length, (index) => Tab(child:  Container(
            decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: AppColors.black, width: 0.1))),
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 5),
            height: double.infinity,
            width: double.infinity,
            child: Text(
              // tabs.elementAt(index).tr,
              index == 0 ?
              controller.selectedCountry.value.countryName ?? ""
                  : tabs.elementAt(index).tr,
              textAlign: TextAlign.center,
            ),
          ),))
      ),
    );
  }

  // TABS VIEWS
  Widget tabViews() {
    SearchController searchController = Get.find<SearchController>();
    var countryId = controller.selectedCountry.value.id;
    return Flexible(
      child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Obx(() =>
              (controller.loading() && controller.spots.isEmpty) ?
              Center(child: CircularProgressIndicator(),) :
              SingleChildScrollView(child: HorizontalList(spots: controller.spots.where((s) => s.idCountry == countryId).toList(),))
            ),

            // GROUPED BY DISTRICTS
            Obx(() => GroupList(
                isDistrict: true,
                districts: searchController.districts,
                spots: controller.spots.where((s) => s.idCountry == countryId).toList(),
                loading: (controller.loading() && controller.spots.isEmpty)
            )),

            // GROUPED BY COUNTIES
            Obx(() => GroupList(
                isDistrict: false,
                counties: searchController.counties,
                spots: controller.spots.where((s) => s.idCountry == countryId).toList(),
                loading: (controller.loading() && controller.spots.isEmpty)
            )),
          ]
      ),
    );
  }

  // FLOAT BUTTON
  Widget mapButton() {
    return InkWell(
      onTap: controller.changeView,
      child: Container(
          decoration: BoxDecoration(color: AppColors.white, border: Border.all(color: AppColors.darkGrey)),
          padding: EdgeInsets.all(8.0),
          child: SvgPicture.asset(controller.showMap.value ? "assets/images/svgs/window.svg" : "assets/images/svgs/paper_map.svg")
      ),
    );
  }
}
