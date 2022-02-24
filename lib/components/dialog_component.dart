import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vyv/components/login_form.dart';
import 'package:vyv/utils/app_colors.dart';
import 'package:vyv/utils/size_config.dart';
import 'package:vyv/widgets/space.dart';
import 'package:vyv/widgets/text_component.dart';

class DialogComponent extends StatefulWidget {
  const DialogComponent({Key? key}) : super(key: key);

  @override
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: LoginForm(),
    );
  }
}

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

