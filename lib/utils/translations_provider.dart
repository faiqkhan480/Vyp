import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vyv/utils/app_translation.dart';

class TranslationProvider {
  Future<AppTranslations?> getTranslations() async {
    String en = await rootBundle.loadString('assets/lang/en_us.json');
    // var jsonResult = jsonDecode(en);
    // var jsonResult = AppTranslations.fromJson(en);
    // return jsonResult;
    return null;
  }
}