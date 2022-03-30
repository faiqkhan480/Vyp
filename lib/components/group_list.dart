import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/widgets/text_component.dart';

import 'horizontal_list.dart';

class GroupList extends StatelessWidget {
  final SearchController? controller;
  final bool isDistrict;
  final bool loading;
  final List<District>? districts;
  final List<County>? counties;
  final List<Spot>? spots;
  const GroupList({
    Key? key,
    this.controller,
    required this.isDistrict,
    this.counties,
    this.districts,
    this.spots,
    this.loading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(loading)
      return Center(child: CircularProgressIndicator());
    return CupertinoScrollbar(
      // child: ListView.builder(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate((isDistrict ? districts?.length : counties?.length) ?? 0, renderChild),
        ),
      ),
    );
  }

  bool handleType(Spot element, index) => isDistrict ? element.idDistrict == districts!.elementAt(index).id : element.idCounty == counties!.elementAt(index).id;

  Widget renderChild(index) {
    String? _itemName = isDistrict ? districts?.elementAt(index).name : counties?.elementAt(index).name;
    int? _itemId = isDistrict ? districts?.elementAt(index).id : counties?.elementAt(index).id;
    List _items = spots!.where((element) => handleType(element, index)).toList();
    if(_items.isNotEmpty)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0),
            child: TextWidget(text: _itemName ?? "", size: 3,),
          ),
          HorizontalList(spots: _items as List<Spot>, isCountry: false, parentId: _itemId,),
        ],
      );
    return SizedBox();
  }
}
