import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/models/spot_model.dart';
import 'package:vyv/utils/size_config.dart';

import 'list_card.dart';

class CountryList extends StatelessWidget {
  final List<Spot>? spots;
  const CountryList({Key? key, this.spots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if(spots!.isEmpty)
    //   return SizedBox();
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.heightMultiplier * 50,
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: spots?.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 1.0,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6),
          itemBuilder: (context, index) => ListCard(index: index, item: spots?.elementAt(index),),
        ),
      ),
    );
  }
}
