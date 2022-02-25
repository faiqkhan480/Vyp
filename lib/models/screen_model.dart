import 'package:flutter/material.dart';

class ScreenModel {
  final String? name;
  final int? navKey;
  final MaterialColor? colors;
  static const _shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  get shades => _shades;
  ScreenModel({this.name, this.colors, this.navKey});
  Color getColorByShade(shade) => colors![shade]!;
}