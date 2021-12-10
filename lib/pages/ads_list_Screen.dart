import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';
import 'package:office_flutter_translate_app/pages/widgets/native_ad_container.dart';

import 'widgets/native_ad_small_container.dart';

class AdsListScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/ads_list_screen';

  @override
  _AdsListScreenState createState() => _AdsListScreenState();
}

class _AdsListScreenState extends State<AdsListScreen> {
  NativeAdmobController _nativeAdController = NativeAdmobController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nativeAdController.reloadAd(forceRefresh: false, numberAds: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: ListView.builder(
          addAutomaticKeepAlives: true,
            itemCount: 50,
            itemBuilder: (context,index){
              if(index % 4 == 0) {
                return
                  NativeAdSmallContainer(nativeAdmobController: _nativeAdController,);
                  // Container(
                  //   // height: 280,
                  //   height: 330,
                  //   width: MediaQuery.of(context).size.width,
                  //   padding: EdgeInsets.all(10),
                  //
                  //   margin: EdgeInsets.all(10.0),
                  //
                  //   decoration: BoxDecoration(
                  //     // color: Colors.brown,
                  //       border: Border.all(width: 2, color: Color(0xfff2ba6de)),
                  //       borderRadius: BorderRadius.all(Radius.circular(30))),
                  //
                  //   child: NativeAdmob(
                  //     // Your ad unit id
                  //     loading: Center(child: Container()),
                  //     error: Center(child: Text("Failed to load the ad")),
                  //     controller: _nativeAdController,
                  //     // controller: _nativeAdController,
                  //     adUnitID: AdsIds.nativeAdsId,
                  //     numberAds: 1,
                  //     type: NativeAdmobType.full,
                  //   ),
                  // );
              }
          return Container(
            height: 100,
            width: double.infinity,
            color: Colors.red,
          );
        }),
      ),
    );
  }
}

class AdsContainer extends StatefulWidget {

  final NativeAdmobController nativeAdmobController;

  const AdsContainer({Key key, this.nativeAdmobController}) : super(key: key);

  @override
  _AdsContainerState createState() => _AdsContainerState();
}

class _AdsContainerState extends State<AdsContainer> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
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
        controller: widget.nativeAdmobController,
        // controller: _nativeAdController,
        adUnitID: AdsIds.nativeAdsId,
        numberAds: 3,
        type: NativeAdmobType.full,
      ),
    );
  }
}

