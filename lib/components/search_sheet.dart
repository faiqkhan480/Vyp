import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district.dart';
import 'package:vyv/models/search_model.dart';
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
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(controller.districts.length, districtTile),
        ),
      ),
    );
  }

  Widget districtTile(index) {
    District _district = controller.districts.elementAt(index);
    List<County> _counties = controller.counties.where((c) => c.idDistrict == _district.id).toList();
    return Obx(
        () => ExpansionTile(
        // title: TextWidget(text: controller.districts.elementAt(index).districtName),
        title: CheckboxListTile(
          title: TextWidget(text: _district.districtName),
          value: controller.selected.any((element) => element.district.id == _district.id),
          onChanged: (value) => controller.handleDistrict(value!, _district, _counties),
        ),
        children: List.generate(_counties.length, (countyIndex) => countiesTile(countyIndex, _district, _counties.elementAt(countyIndex))),
        // initiallyExpanded: true,
      ),
    );
  }

  Widget countiesTile(int index, District district,  County county) {
    return Obx(() {
        // SelectedDistrict _selected = controller.selected.firstWhere((element) => element.district.id == district.id);
        return CheckboxListTile(
          title: TextWidget(text: county.countyName),
          value: controller.selected.firstWhere((element) => element.district.id == district.id).counties.any((c) => c.id == county.id),
          onChanged: (value) => controller.handleCounty(value!, district, county),
        );
      },
    );
  }
}
