import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/text_component.dart';

class SearchBottomSheet extends GetView<SearchController> {
// class SearchBottomSheet extends StatelessWidget {
  // const SearchBottomSheet({Key? key}) : super(key: key);

  // SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    // print(controller.districts);
    return Container(
      color: AppColors.secondaryColor,
      padding: EdgeInsets.symmetric(vertical: 20),
      height: Get.height * 0.90,
      child: ListView.builder(
        itemCount: controller.districts.length,
        itemBuilder: districtTile,
      ),
    );
  }

  Widget districtTile(context, index) {
    List<County> counties = controller.counties.where((c) => c.idDistrict == controller.districts.elementAt(index).id).toList();
    return ExpansionTile(
      title: TextWidget(text: controller.districts.elementAt(index).districtName),
      children: List.generate(counties.length, (countyIndex) => countiesTile(countyIndex, counties.elementAt(countyIndex))),
      // initiallyExpanded: true,
    );
  }

  Widget countiesTile(int index, County county) {
    return CheckboxListTile(
      title: TextWidget(text: county.countyName),
      value: false,
      onChanged: (value) => null,
    );
  }
}
