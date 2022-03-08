import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/controllers/home_controller.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(searchBox),
              Flexible(
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
                              icon: (controller.selected.isNotEmpty && (controller.selected.length != controller.districts.length || controller.selected.every((element) => element.counties!.length != controller.counties.where((c) => c.districtId == element.district!.id).toList().length))) ?
                              CupertinoIcons.minus :  Icons.check,
                            )),
                          ],
                        ),
                      ),
                      ...List.generate(controller.districts.length, districtTile),
                    ],
                  ),
                ),
              ),
              ElevatedButton(onPressed: handleSubmit, child: TextWidget(text: 'search', color: Colors.white, size: 2.2,),)
            ],
          ),
        ],
      ),
    );
  }

  handleSubmit() {
    Get.find<HomeController>().handleSearch(
        reqIds: {
          "countyId": [],
          "districtId": [],
        }
    );
  }

  Widget districtTile(index) {
    return Obx(() {
      District _district = controller.districts.elementAt(index);
      List<County> _counties = controller.counties.where((c) => c.districtId == _district.id).toList();
      bool _value = controller.selected.any((element) => element.district!.id == _district.id);
      return ExpansionTile(
        // title: TextWidget(text: controller.districts.elementAt(index).districtName),
        title: ListTile(
          title: TextWidget(text: _district.name, size: 2.0,),
          trailing: CustomCheckBox(
            isSelected: controller.selected.any((element) => element.district!.id == _district.id),
            action: () => controller.handleByDistrict(!_value, _district, _counties),
            icon:
            (_value && controller.selected.firstWhere((element) => element.district!.id == _district.id).counties!.length != _counties.length) ?
            CupertinoIcons.minus :  Icons.check,
          ),
          onTap: () => selectAllCounties(!_value, _district, _counties),
        ),
        children: List.generate(
            _counties.length,
            (countyIndex) => countyTile(
                countyIndex,
                _district,
                _counties,
                  // () => selectAllCounties(!_value, _district, _counties),
                // controller.selected.firstWhere((element) => element.district!.id == _district.id).counties!.length != _counties.length
            )
        ),
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

  Widget countyTile(int countyIndex, District _district,  List<County> _counties) {
    SelectedDistrict? _selected = controller.selected.firstWhereOrNull((element) => element.district!.id == _counties.elementAt(countyIndex).districtId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if(countyIndex == 0)
          CheckboxListTile(
            title: TextWidget(text: "select_all", size: 1.8,),
            value: (_selected?.counties?.length ?? 0) == _counties.length,
            onChanged: (value) => controller.handleAllCountySelection(value ?? true, _district,),
          ),

        CheckboxListTile(
          title: TextWidget(text: _counties.elementAt(countyIndex).name, size: 1.8,),
          value: _selected?.counties?.any((c) => c.id == _counties.elementAt(countyIndex).id) ?? false,
          onChanged: (value) => controller.handleByCounty(value!, _district, _counties.elementAt(countyIndex)),
        ),
      ],
    );
  }

  Widget searchBox() {
    return Container(
        child: Wrap(
            children: [
              // for (int index = 0; index < sItems.length; index++)
              //   (sItems.isNotEmpty)
              //       ? IntrinsicWidth(
              //       child: Container(
              //         height: 60,
              //         alignment: Alignment.centerLeft,
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Center(
              //             child: GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   for (int i = 0; i < data.length; i++)
              //                     for (int j = 0;
              //                     j < data[i].listClubs.length;
              //                     j++)
              //                       for (int k = 0;
              //                       k <
              //                           data[i]
              //                               .listClubs[j]
              //                               .listPlayers
              //                               .length;
              //                       k++)
              //                         if (data[i]
              //                             .listClubs[j]
              //                             .listPlayers[k]
              //                             .parentId ==
              //                             0) {
              //                           for (int l = 0; l <
              //                               data.length; l++)
              //                             for (int m = 0;
              //                             m < data[l].listClubs
              //                                 .length;
              //                             m++)
              //                               for (int n = 0;
              //                               n <
              //                                   data[l]
              //                                       .listClubs[m]
              //                                       .listPlayers
              //                                       .length;
              //                               n++)
              //                                 (sItems[index] ==
              //                                     data[l]
              //                                         .listClubs[m]
              //                                         .clubName)
              //                                     ? data[l]
              //                                     .listClubs[m]
              //                                     .listPlayers[n]
              //                                     ._isChecked = false
              //                                     : Container();
              //                         } else
              //                           (sItems[index] ==
              //                               data[i].countryName)
              //                               ?
              //                           data[i]._isChecked = false
              //                               : (sItems[index] ==
              //                               data[i]
              //                                   .listClubs[j]
              //                                   .clubName)
              //                               ? data[i]
              //                               .listClubs[j]
              //                               ._isChecked = false
              //                               : sItems[index] ==
              //                               data[i]
              //                                   .listClubs[j]
              //                                   .listPlayers[k]
              //                                   .playerName
              //                               ? data[i]
              //                               .listClubs[j]
              //                               .listPlayers[k]
              //                               ._isChecked = false
              //                               : data[i]
              //                               .listClubs[j]
              //                               .clubName ==
              //                               sItems[index]
              //                               ? data[i]
              //                               .listClubs[j]
              //                               .listPlayers[k]
              //                               ._isChecked = false
              //                               : Container();
              //
              //                   sItems.removeAt(index);
              //                   // print(data.length);
              //                 });
              //               },
              //               child: Container(
              //                   decoration: BoxDecoration(
              //                     color: Colors.green,
              //                     borderRadius: BorderRadius.circular(
              //                         12),
              //                   ),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(5.0),
              //                     child: Row(
              //                       mainAxisAlignment:
              //                       MainAxisAlignment.spaceEvenly,
              //                       children: [
              //                         Text(
              //                           sItems[index],
              //                           style: TextStyle(
              //                               color: Colors.white,
              //                               fontSize: 16),
              //                         )
              //                         ,
              //                         SizedBox(width: 5.0,),
              //                         Icon(
              //                           Icons.cancel,
              //                           color: Colors.white,
              //                           size: 16,
              //                         )
              //                       ],
              //                     ),
              //                   )),
              //             ),
              //           ),
              //         ),
              //       )
              //   )
              //       : Container(),
              ...List.generate(controller.selectedItems.length, (index) => IntrinsicWidth(
                  child: Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => controller.removeSearchItems(controller.selectedItems.elementAt(index)),
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
                                    Text(
                                      (controller.selectedItems.elementAt(index).runtimeType == District) ?
                                      controller.selectedItems.elementAt(index)?.name :
                                      controller.selectedItems.elementAt(index)?.name,
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
