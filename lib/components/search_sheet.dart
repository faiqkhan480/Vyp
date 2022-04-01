import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/search_model.dart';
import 'package:vyv/models/sub_category_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:collection/collection.dart';
import 'package:vyv/widgets/text_component.dart';

import 'custom_checkbox.dart';

class SearchBottomSheet extends GetView<SearchController> {
// class SearchBottomSheet extends StatelessWidget {
  final bool isCategory;
  const SearchBottomSheet(this.isCategory, {Key? key}) : super(key: key);

  // SearchController controller = Get.put(SearchController());

  handleSubmit() => Get.find<HomeController>().handleSearch(pageKey: 1, extraParams: controller.selectedItems, isCategory: isCategory);

  void selectAllCounties(_value, _district, _counties) => controller.handleByDistrict(_value, _district, _counties, isCategory);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor,
      padding: EdgeInsets.symmetric(vertical: 20),
      height: Get.height * 0.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(searchBox),
                  // CHECK BOX FOR SELECTION ALL ITEMS
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
                        Obx(() {
                          var _length = isCategory ? controller.categories.length : controller.districts.length;
                          var _items = isCategory ? controller.categories : controller.districts;
                          var _childItems = isCategory ? controller.subCategories : controller.counties;
                          return CustomCheckBox(
                            isSelected: controller.selectedDistricts.length == _length,
                            action: () => controller.handleByCountry(isCategory),
                            icon: (controller.selectedDistricts.isNotEmpty &&
                                (controller.selectedDistricts.length != _length || controller.selectedDistricts.every((element) =>
                                element.children!.length != (isCategory ? controller.subCategories.where((c) => c.categoryId == element.parent!.id).toList().length : controller.counties.where((c) => c.districtId == element.parent!.id).toList().length)
                                ))) ?
                            CupertinoIcons.minus :  Icons.check,
                          );
                        }),
                      ],
                    ),
                  ),
                  ...List.generate(isCategory ? controller.categories.length : controller.districts.length, parentItem),
                ],
              ),
            ),
          ),
          ElevatedButton(onPressed: handleSubmit, child: TextWidget(text: 'search', color: Colors.white, size: 2.2,),)
        ],
      ),
    );
  }

  // PARENT ITEM SELECTION
  Widget parentItem(index) {
    return Obx(() {
      dynamic _parent = isCategory ? controller.categories.elementAt(index) : controller.districts.elementAt(index);
      List<dynamic> _children = isCategory ? controller.subCategories.where((c) => c.categoryId == _parent.id).toList() : controller.counties.where((c) => c.districtId == _parent.id).toList();
      bool _value = controller.selectedDistricts.any((element) => element.parent!.id == _parent.id);
      return ExpansionTile(
        // title: TextWidget(text: controller.districts.elementAt(index).districtName),
        title: ListTile(
          title: TextWidget(text: _parent.name, size: 2.0,),
          trailing: CustomCheckBox(
            isSelected: controller.selectedDistricts.any((element) => element.parent.runtimeType == _parent.runtimeType && element.parent!.id == _parent.id),
            action: () => controller.handleByDistrict(!_value, _parent, _children, isCategory),
            // action: () => null,
            icon:
            (_value && controller.selectedDistricts.firstWhere((element) => element.parent!.id == _parent.id).children!.length != _children.length) ?
            CupertinoIcons.minus :  Icons.check,
          ),
          onTap: () => selectAllCounties(!_value, _parent, _children),
        ),
        children: List.generate(
            _children.length,
            (itemIndex) => childItem(
              itemIndex,
              _parent,
              _children,
                  // () => selectAllCounties(!_value, _district, _counties),
                // controller.selected.firstWhere((element) => element.district!.id == _district.id).counties!.length != _counties.length
            )
        ),
      );
    });
  }

  // CHILD ITEM SELECTION
  Widget childItem(int childIndex, dynamic _parentItem,  List<dynamic> _childItems) {
    SelectedDistrict? _selected = controller.selectedDistricts.firstWhereOrNull((element) => element.parent!.id == (isCategory ? _childItems.elementAt(childIndex).categoryId : _childItems.elementAt(childIndex).districtId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if(childIndex == 0)
          CheckboxListTile(
            title: TextWidget(text: "select_all", size: 1.8,),
            value: (_selected?.children?.length ?? 0) == _childItems.length,
            onChanged: (value) => controller.handleAllCountySelection(value ?? true, _parentItem, isCategory),
          ),

        CheckboxListTile(
          title: TextWidget(text: _childItems.elementAt(childIndex).name, size: 1.8,),
          value: _selected?.children?.any((c) => c.runtimeType == _childItems.elementAt(childIndex).runtimeType && c.id == _childItems.elementAt(childIndex).id) ?? false,
          onChanged: (value) => controller.handleByCounty(value!, _parentItem, _childItems.elementAt(childIndex), isCategory),
        ),
      ],
    );
  }

  Widget searchBox() {
    List _items = controller.selectedItems.where((e) => isCategory ? e.runtimeType == Category : true).toList();
    return Container(
        child: Wrap(
            children: [
              ...List.generate(_items.length, (index) => IntrinsicWidth(
                  child: Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => controller.removeSearchItems(_items.elementAt(index), isCategory),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text( _items.elementAt(index)?.name,
                                      // (controller.selectedItems.elementAt(index).runtimeType == District || controller.selectedItems.elementAt(index).runtimeType == Category) ?
                                      // controller.selectedItems.elementAt(index)?.name :
                                      // controller.selectedItems.elementAt(index)?.name,
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(width: 5.0,),
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  )
              )),
              IntrinsicWidth(
                  child:TextField(
                      decoration: InputDecoration(
                          hintText: "Search Here...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0,),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Icon(Icons.search)
                      )
                  )
              )
            ]
        )
    );
  }
}
