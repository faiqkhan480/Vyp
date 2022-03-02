import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district.dart';
import 'package:vyv/models/search_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/text_component.dart';

import 'custom_checkbox.dart';

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
    return Obx(() {
      bool _value = controller.selected.any((element) => element.district.id == _district.id);
      return ExpansionTile(
        // title: TextWidget(text: controller.districts.elementAt(index).districtName),
        title: ListTile(
          title: TextWidget(text: _district.districtName, size: 2.0,),
          trailing: CustomCheckBox(
            isSelected: controller.selected.any((element) => element.district.id == _district.id),
            action: () => controller.handleDistrict(!_value, _district, _counties),
            icon:
            (_value && controller.selected.firstWhere((element) => element.district.id == _district.id).counties.length != _counties.length) ?
            CupertinoIcons.minus :  Icons.check,
          ),
          onTap: () => controller.handleDistrict(!_value, _district, _counties),
        ),
        children: List.generate(_counties.length, (countyIndex) => countiesTile(countyIndex, _district, _counties.elementAt(countyIndex))),
        // initiallyExpanded: true,
      );
    });
  }

  Widget countiesTile(int index, District district,  County county) {
    return CheckboxListTile(
      title: TextWidget(text: county.countyName, size: 1.8,),
      // value: controller.check(),
      value: controller.selected.isNotEmpty ? controller.selected.firstWhere((element) => element.district.id == district.id).counties.any((c) => c.id == county.id) : false,
      onChanged: (value) => controller.handleCounty(value!, district, county),
    );
  }
}
