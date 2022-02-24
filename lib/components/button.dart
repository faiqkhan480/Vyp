import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool? isFlat;
  final double? radius;
  final Color? color;

  const Button(this.text, {required this.onPressed, this.isFlat, this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text.tr),
      style: TextButton.styleFrom(
          primary: isFlat != null ? AppColors.white : color,
          backgroundColor: color ?? Colors.transparent,
          shape: isFlat != null ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 100),
            // side: BorderSide(color: AppColors.primaryColor)
          ) : null,
          textStyle: TextStyle(fontSize: isFlat == null ? 13 :  SizeConfig.textMultiplier * 2.2, fontWeight: isFlat != null ? FontWeight.w400 : FontWeight.w700)
      ),
    );
  }
}