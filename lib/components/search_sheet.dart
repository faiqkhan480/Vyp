import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/countries_controller.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/category_model.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/search_model.dart';
import 'package:vyv/models/sub_category_model.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/widgets/text_component.dart';

import 'custom_checkbox.dart';

class SearchBottomSheet extends GetView<SearchController> {
  final bool isCategory;

  const SearchBottomSheet(this.isCategory, {Key? key}) : super(key: key);

  // ON CALLED WHEN TAP ON SEARCH BUTTON
  handleSubmit() {
    Get.find<HomeController>().handleSearch(
        pageKey: 1,
        extraParams: isCategory ? [
          ...controller.categoryParents,
          ...controller.categoryChildren
        ] : [...controller.districtsParents, ...controller.countyChildren],
        isCategory: isCategory);
  }

  // SELECT ALL COUNTY ITEMS HANDLER
  void selectAllCounties(_value, _parent, _children) =>
      isCategory
          ? controller.handleByCategory(_value, _parent, _children)
          : controller.handleByDistrict(_value, _parent, _children, isCategory);

  bool getChildLength() {
    bool _length = false;
    controller.selectedCategories.forEach((element) {
      if(element.children!.length == controller.categoryChildren.where((p) => p.categoryId == element.parent.id).toList().length)
        _length = true;
    });
    return _length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.only(top: 50),
      height: Get.height * 0.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Obx(() {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SEARCH FIELD
                    Obx(searchBox),
                    // CHECK BOX FOR SELECTION ALL ITEMS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: Get.find<HomeController>().selectedCountry.value.countryName,
                            size: 2.2,
                          ),
                          Obx(() {
                            var _length = isCategory ? controller.categories.length : controller.districts.length;
                            var _items = isCategory ? controller.searchCategories : controller.searchDistricts;
                            var _childItems = isCategory ? controller.searchSubCategories : controller.searchCounties;
                            var _selected = controller.selectedDistricts.where((e) => isCategory ? e is Category : e is District).toList();
                            bool _childLength = false;
                            if(isCategory) {
                              _childLength = controller.selectedCategories.every((element) => element.children!.length == controller.categoryChildren.where((p) => p.categoryId == element.parent.id).toList().length);
                            }
                            else {
                              _childLength = controller.selectedDistricts.every((element) => element.children!.length == controller.countyChildren.where((p) => p.districtId == element.parent.id).toList().length);
                            }
                            return CustomCheckBox(
                              // isSelected: controller.selectedItems.length == _length ,
                              isSelected: controller.selectedItems.isNotEmpty ,
                              action: () => isCategory ?
                              controller.handleAllCategorySelection(controller.selectedItems.length == controller.categories.length) :
                              controller.handleByCountry(controller.selectedItems.length == controller.districts.length),
                              icon:
                              controller.selectedItems.isEmpty ? null :
                              (controller.selectedItems.length != _length || _childLength) ?
                              CupertinoIcons.minus :
                              Icons.check,
                            );
                          }),
                        ],
                      ),
                    ),
                    ...List.generate(
                        isCategory ?
                        controller.searchCategories.length :
                        controller.searchDistricts.length,
                        parentItem
                    ),
                  ],
                ),
              );
            }),
          ),
          ElevatedButton(onPressed: handleSubmit,
            child: TextWidget(text: 'search', color: Colors.white, size: 2.2,),)
        ],
      ),
    );
  }

  // PARENT ITEM SELECTION
  Widget parentItem(index) {
    return Obx(() {
      dynamic _parent = isCategory ? controller.searchCategories.elementAt(
          index) : controller.searchDistricts.elementAt(index);
      List<dynamic> _children = isCategory ? controller.searchSubCategories
          .where((c) => c.categoryId == _parent.id).toList() : controller
          .searchCounties.where((c) => c.districtId == _parent.id).toList();
      bool _value = isCategory ? controller.selectedCategories.any((
          element) => element.parent!.id == _parent.id) : controller
          .selectedDistricts.any((element) => element.parent!.id == _parent.id);
      return ExpansionTile(
        title: ListTile(
          title: TextWidget(text: _parent.name, size: 2.0,),
          trailing: CustomCheckBox(
            isSelected: _value,
            action: () =>
            isCategory ?
            controller.handleByCategory(!_value, _parent, _children as List<SubCategory>) :
            controller.handleByDistrict(!_value, _parent, _children, isCategory),
            icon: _children.isEmpty ?
            null :
            (_value &&
                (isCategory ?
                controller.selectedCategories.firstWhere((e) => e.parent!.id == _parent.id) :
                controller.selectedDistricts.firstWhere((e) => e.parent!.id == _parent.id)).children!.length != _children.length) ?
            CupertinoIcons.minus :
            Icons.check,
          ),
          onTap: () => selectAllCounties(!_value, _parent, _children),
        ),
        children: List.generate(
            _children.length,
                (itemIndex) =>
                childItem(
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
  Widget childItem(int childIndex, dynamic _parentItem, List<dynamic> _childItems) {
    SelectedItems? _selected = !isCategory ?
    controller.selectedDistricts.firstWhereOrNull((element) =>
    element.parent!.id == _childItems.elementAt(childIndex).districtId) :
    controller.selectedCategories.firstWhereOrNull((element) =>
        element.parent!.id == _childItems
        .elementAt(childIndex)
        .categoryId);
    List _selectedSubCat = controller.selectedDistricts
        .firstWhereOrNull((cat) =>
    cat.parent.runtimeType == _parentItem.runtimeType &&
        cat.parent.id == _parentItem.id)
        ?.children ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // if(childIndex == 0)
        //   CheckboxListTile(
        //     title: TextWidget(text: "select_all", size: 1.8,),
        //     value: (_selected?.children?.length ?? 0) == _childItems.length,
        //     onChanged: (value) => isCategory ? controller.handleAllSubCategorySelection(value ?? true, _parentItem) : controller.handleAllCountySelection(value ?? true, _parentItem, isCategory),
        //   ),

        CheckboxListTile(
          title: TextWidget(text: _childItems
              .elementAt(childIndex)
              .name, size: 1.8,),
          value: _selected?.children?.any((c) =>
          c.id == _childItems
              .elementAt(childIndex)
              .id) ?? false,
          onChanged: (value) =>
          isCategory
              ? controller.handleBySubCategory(
            value!, _parentItem, _childItems.elementAt(childIndex),)
              : controller.handleByCounty(
              value!, _parentItem, _childItems.elementAt(childIndex),
              isCategory),
        ),
      ],
    );
  }

  Widget searchBox() {
    bool allSelection = isCategory ? controller.allCategories() : controller.allDistricts();
    List _items = controller.selectedItems.where((e) =>
    isCategory
        ? (e is Category || e is SubCategory)
        : (e is District || e is County)).toList();
    return Container(
        child: Wrap(
            children: [
              if(allSelection)
                IntrinsicWidth(
                    child: Container(
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: GestureDetector(
                            onTap: () => isCategory ?
                            controller.handleAllCategorySelection(true) :
                            controller.handleByCountry(true),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Text(Get.find<HomeController>().selectedCountry.value.countryName ?? "",
                                        style: TextStyle(color: Colors.white,
                                            fontSize: 16),
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
                )
              else
              ...List.generate(_items.length, (index) =>
                  IntrinsicWidth(
                      child: Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: GestureDetector(
                              onTap: () =>
                                  controller.removeSearchItems(_items.elementAt(index), isCategory),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text(_items
                                            .elementAt(index)
                                            ?.name,
                                          // (controller.selectedItems.elementAt(index).runtimeType == District || controller.selectedItems.elementAt(index).runtimeType == Category) ?
                                          // controller.selectedItems.elementAt(index)?.name :
                                          // controller.selectedItems.elementAt(index)?.name,
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 16),
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
                  child: TextField(
                      controller: isCategory ? controller.categorySearch : controller.countrySearch,
                      onChanged: (value) => controller.handleSearchChange(value, isCategory),
                      maxLength: 30,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
                      ],
                      decoration: InputDecoration(
                        counter: SizedBox(),
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
