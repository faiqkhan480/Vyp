import 'package:flutter/material.dart';
import 'package:vyv/controllers/search_controller.dart';
import 'package:vyv/widgets/text_component.dart';

import 'country_list.dart';

class GroupList extends StatelessWidget {
  final SearchController? controller;
  final bool isDistrict;
  const GroupList({Key? key,  this.controller, required this.isDistrict}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextWidget(text: "\tFundão - Castelo Branco", size: 3,),
          CountryList(),
        ],
      ),
    );
  }
}
