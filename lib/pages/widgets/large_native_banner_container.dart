import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class LargeNativeBannerContainer extends StatefulWidget {

  static const _adUnitID = "ca-app-pub-3940256099942544/8135179316";

  @override
  _LargeNativeBannerContainerState createState() => _LargeNativeBannerContainerState();
}

class _LargeNativeBannerContainerState extends State<LargeNativeBannerContainer> {
  final _nativeAdController = NativeAdmobController();


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20.0),
      child: NativeAdmob(
        // Your ad unit id
        loading: Center(child: Container()),
        error: Text("Failed to load the ad"),
        controller: _nativeAdController,
        // controller: _nativeAdController,
        adUnitID: LargeNativeBannerContainer._adUnitID,
        numberAds: 1,
        type: NativeAdmobType.full,
      ),
    );
  }
}
