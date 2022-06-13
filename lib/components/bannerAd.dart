import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vyv/utils/admob_service.dart';
import 'package:vyv/utils/size_config.dart';

class BanneAd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdWidget(
      key: UniqueKey(),
      ad: AdMobService.createBannerAd()..load(),
      // ad: AdMobService.renderNativeAd()..load(),
    );
  }
}
