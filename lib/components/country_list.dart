import 'package:flutter/material.dart';
import 'package:vyv/utils/size_config.dart';

import 'list_card.dart';

class CountryList extends StatelessWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity,
        height: 330,
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 20),
         shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 30,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 1.0,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6),
          itemBuilder: (context, index) => ListCard(index: index,),
        ),
      ),
    );
  }
}
