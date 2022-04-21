import 'package:flutter/material.dart';
import 'package:vyv/utils/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  final VoidCallback action;
  final bool isSelected;
  final IconData? icon;
  final bool isShow;
  const CustomCheckBox({Key? key, required this.action, required this.isSelected, this.icon, this.isShow = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: AnimatedContainer(
        duration: Duration(microseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(2.0),
          border: isSelected ? null : Border.all(color: Colors.black54, width: 2.0)
        ),
        height: 25,
        width: 25,
        child: isSelected && isShow && icon != null ? Icon(icon, color: AppColors.white,) : null,
      ),
    );
  }
}
