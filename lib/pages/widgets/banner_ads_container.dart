import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';

class BannerAdsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      child: AdmobBanner(
          adUnitId: AdsIds.bannerAdsId,
          adSize: AdmobBannerSize.FULL_BANNER),
    );
  }
}
