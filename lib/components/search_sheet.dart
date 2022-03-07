import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district.dart';
import 'package:vyv/models/search_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:collection/collection.dart';
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    // text: Get.find<HomeController>().selectedCountry.value.countryName,
                    text: "select_all",
                    size: 2.2,
                  ),
                  Obx(() => CustomCheckBox(
                    isSelected: controller.selected.length == controller.districts.length,
                    action: () => controller.handleByCountry(),
                    icon: (controller.selected.isNotEmpty && (controller.selected.length != controller.districts.length || controller.selected.every((element) => element.counties!.length != controller.counties.where((c) => c.idDistrict == element.district!.id).toList().length))) ?
                    CupertinoIcons.minus :  Icons.check,
                  )),
                ],
              ),
            ),
            ...List.generate(controller.districts.length, districtTile),
          ],
        ),
      ),
    );
  }

  Widget districtTile(index) {
    return Obx(() {
      District _district = controller.districts.elementAt(index);
      List<County> _counties = controller.counties.where((c) => c.idDistrict == _district.id).toList();
      bool _value = controller.selected.any((element) => element.district!.id == _district.id);
      return ExpansionTile(
        // title: TextWidget(text: controller.districts.elementAt(index).districtName),
        title: ListTile(
          title: TextWidget(text: _district.districtName, size: 2.0,),
          trailing: CustomCheckBox(
            isSelected: controller.selected.any((element) => element.district!.id == _district.id),
            action: () => controller.handleByDistrict(!_value, _district, _counties),
            icon:
            (_value && controller.selected.firstWhere((element) => element.district!.id == _district.id).counties!.length != _counties.length) ?
            CupertinoIcons.minus :  Icons.check,
          ),
          onTap: () => selectAllCounties(!_value, _district, _counties),
        ),
        children: List.generate(_counties.length, (countyIndex) => countyTile(countyIndex, _district, _counties, () => selectAllCounties(!_value, _district, _counties))),
        // children: List.generate(_counties.length, (countyIndex) {
        //   SelectedDistrict? _selected = controller.selected.firstWhereOrNull((element) => element.district!.id == _counties.elementAt(countyIndex).idDistrict);
          // return CheckboxListTile(
          //   title: TextWidget(text: _counties.elementAt(countyIndex).countyName, size: 1.8,),
          //   value: _selected?.counties?.any((c) => c.id == _counties.elementAt(countyIndex).id) ?? false,
          //   onChanged: (value) => controller.handleByCounty(value!, _district, _counties.elementAt(countyIndex)),
          // );
        // }),
        // initiallyExpanded: true,
      );
    });
  }

  void selectAllCounties(_value, _district, _counties) => controller.handleByDistrict(_value, _district, _counties);

  Widget countyTile(int countyIndex, District _district,  List<County> _counties, selectAll) {
    SelectedDistrict? _selected = controller.selected.firstWhereOrNull((element) => element.district!.id == _counties.elementAt(countyIndex).idDistrict);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if(countyIndex == 0)
          CheckboxListTile(
            title: TextWidget(text: "select_all", size: 1.8,),
            value: _selected?.counties?.any((c) => c.id == _counties.elementAt(countyIndex).id) ?? false,
            onChanged: (value) => selectAll(),
          ),

        CheckboxListTile(
          title: TextWidget(text: _counties.elementAt(countyIndex).countyName, size: 1.8,),
          value: _selected?.counties?.any((c) => c.id == _counties.elementAt(countyIndex).id) ?? false,
          onChanged: (value) => controller.handleByCounty(value!, _district, _counties.elementAt(countyIndex)),
        ),
      ],
    );
  }
}
