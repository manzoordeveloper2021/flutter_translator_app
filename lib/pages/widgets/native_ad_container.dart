import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';

class NativeAdContainer extends StatelessWidget {
  final NativeAdmobController nativeAdmobController;

  const NativeAdContainer({Key key, this.nativeAdmobController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 280,
      height: 330,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),

      margin: EdgeInsets.all(10.0),

      decoration: BoxDecoration(
        // color: Colors.brown,
          border: Border.all(width: 2, color: Color(0xfff2ba6de)),
          borderRadius: BorderRadius.all(Radius.circular(30))),

      child: NativeAdmob(
        // Your ad unit id
        loading: Center(child: Container()),
        error: Center(child: Text("Failed to load the ad")),
        controller: nativeAdmobController,
        // controller: _nativeAdController,
        adUnitID: AdsIds.nativeAdsId,
        numberAds: 3,
        type: NativeAdmobType.full,
      ),
    );
  }
}
