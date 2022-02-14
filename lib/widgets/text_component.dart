import 'package:flutter/material.dart';
import 'package:vyp/utils/size_config.dart';
import 'package:get/get.dart';

class TextWidget extends StatelessWidget {
  final String? text, family;
  final FontWeight? weight;
  final Color? color;
  final num? size;
  final bool? shadow;
  final TextAlign align;

  const TextWidget({Key? key,
    this.size = 1.9,
    required this.text,
    this.weight = FontWeight.w400,
    this.color,
    this.family,
    this.shadow = false,
    this.align = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text!.tr, textAlign: align, style: TextStyle(
      color: color ?? Colors.black,
      fontWeight: weight,
      fontFamily: family,
      fontSize: SizeConfig.textMultiplier * size!,
      shadows: <Shadow>[
        if(shadow!)
        Shadow(
          offset: Offset(2.0, 4.0),
          blurRadius: 8.0,
          color: Colors.grey,
        ),
      ],
    ),);
  }
}
