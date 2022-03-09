import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vyv/components/country_list.dart';
import 'package:vyv/components/group_list.dart';
import 'package:vyv/components/list_card.dart';
import 'package:vyv/components/map_box.dart';
import 'package:vyv/components/menu_sheet.dart';
import 'package:vyv/components/search_sheet.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';
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
      MenuSheet(isLogin: false,),
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
  handleSearch() {
    Get.bottomSheet(
      SearchBottomSheet(),
      isDismissible: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),),
      enableDrag: false,
      isScrollControlled: true,
      persistent: true,
    );
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
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
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
            Obx(tabViews),
          ]
          else
            MapBox(),
        ],
      ),
    );
  }

  // SEARCH FIELDS
  List<Widget> searchFields() {
    return [
      InputField(
        placeHolder: "what_r_u_looking_for",
        readOnly: true,
        icon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset("assets/images/svgs/rocket.svg"),
        ),
        horizontal: 30,
        vertical: 15,
      ),
      // VerticalSpace(15),
      InputField(
        onTap: handleSearch,
        placeHolder: "where",
        readOnly: true,
        icon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset("assets/images/svgs/location.svg"),
        ),
        horizontal: 30,
        vertical: 0,
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
    return Flexible(
      child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            if(controller.loading() && controller.spots.isEmpty)
              Center(child: CircularProgressIndicator(),)
            else
              countryList(),
              // CountryList(spots: controller.spots,),
            // GROUPED BY DISTRICTS
            GroupList(
                isDistrict: true,
                districts: searchController.districts,
                spots: controller.spots,
                loading: (controller.loading() && controller.spots.isEmpty)
            ),
            // GROUPED BY COUNTIES
            GroupList(
                isDistrict: false,
                counties: searchController.counties,
                spots: controller.spots,
                loading: (controller.loading() && controller.spots.isEmpty)
            ),
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

  Widget countryList() {
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
                  itemCount: controller.spots.length,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 175,
                      maxCrossAxisExtent: 250,
                      // childAspectRatio: 2.0,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6),
                  itemBuilder: (context, index) => ListCard(index: index, item: controller.spots.elementAt(index),),
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
