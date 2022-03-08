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
    return ListView.builder(
      itemCount: isDistrict ? districts?.length : counties?.length,
      itemBuilder: (context, index) {
        String? _itemName = isDistrict ? districts?.elementAt(index).name : counties?.elementAt(index).name;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextWidget(text: _itemName ?? "", size: 3,),
            ),
            CountryList(),
          ],
        );
      },
    );
  }
}
