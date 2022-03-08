import 'package:flutter/material.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/models/county_model.dart';
import 'package:vyv/models/district_model.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/widgets/text_component.dart';

import 'country_list.dart';

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
    return ListView.builder(
      itemCount: isDistrict ? districts?.length : counties?.length,
      itemBuilder: (context, index) {
        String? _itemName = isDistrict ? districts?.elementAt(index).name : counties?.elementAt(index).name;
        List _items = spots!.where((element) => handleType(element, index)).toList();
        if(_items.isNotEmpty)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextWidget(text: _itemName ?? "", size: 3,),
              ),
              CountryList(spots: _items as List<Spot>,),
            ],
          );
        return SizedBox();
      },
    );
  }

  bool handleType(Spot element, index) => isDistrict ? element.idDistrict == districts!.elementAt(index).id : element.idCountry == counties!.elementAt(index).id;
}
