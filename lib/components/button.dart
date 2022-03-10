import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool? isFlat;
  final bool? loading;
  final double? radius;
  final Color? color;
  final Widget? icon;

  const Button(this.text, {required this.onPressed, this.isFlat, this.icon, this.radius, this.color, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: loading! ?
      SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 1.5,)) :
      icon != null ?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5, top: 0, bottom: 0),
            child: icon!,
          ),
          Text(text.tr),
        ],
      ) :
      Text(text.tr),
      style: TextButton.styleFrom(
          primary: isFlat != null ? AppColors.white : color,
          backgroundColor: color ?? Colors.transparent,
          shape: isFlat != null ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 100),
            // side: BorderSide(color: AppColors.primaryColor)
          ) : null,
          padding: EdgeInsets.symmetric(vertical: 15),
          textStyle: TextStyle(fontSize: isFlat == null ? 13 :  SizeConfig.textMultiplier * 2.2, fontWeight: isFlat != null ? FontWeight.w400 : FontWeight.w700)
      ),
    );
  }
}