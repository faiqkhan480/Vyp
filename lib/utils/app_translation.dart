import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';


class AppTranslations extends Translations {
  final Map<String, String> en_US;

  AppTranslations({required this.en_US});

  static Locale? get locale => Locale('en', 'US');
  static final fallbackLocale = Locale('en', 'US');

  static AppTranslations fromJson(dynamic json) {
    return AppTranslations(
      en_US: Map<String, String>.from(json["en_US"]),
    );
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
  };

}