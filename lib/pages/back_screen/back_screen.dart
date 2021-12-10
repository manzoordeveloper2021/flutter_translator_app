import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';

import 'widgets/navigation_container_widget.dart';
import 'widgets/rating_bar_widget.dart';

// ignore: must_be_immutable
class BackScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/back_screen';
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(top: 30.0),
          decoration: BoxDecoration(
            // color: Colors.brown,
            color: Colors.white,
            border: Border.all(width: 2, color: Color(0xfff2ba6de)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  // height: 280,
                  // height: 430,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),

                  margin: EdgeInsets.all(10.0),

                  decoration: BoxDecoration(
                      color: Color(0xff2ba6de),
                      border: Border.all(width: 2, color: Color(0xfff2ba6de)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30), topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),

                    ),

                  ),

                  child: NativeAdmob(
                    // Your ad unit id
                    options: NativeAdmobOptions(
                      //ad button
                      callToActionStyle: NativeTextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          backgroundColor: Color(0xFFde632b)),

                      adLabelTextStyle: NativeTextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        // backgroundColor: Color(0xFF4CBE99)
                      ),
                      headlineTextStyle:
                      NativeTextStyle(fontSize: 16, color: Colors.white),
                      bodyTextStyle:
                      NativeTextStyle(fontSize: 16, color: Colors.white),
                      advertiserTextStyle:
                      NativeTextStyle(fontSize: 16, color: Colors.white),
                      storeTextStyle:
                      NativeTextStyle(fontSize: 16, color: Colors.red),
                    ),

                    loading: Center(child: Container()),
                    error: Center(child: Text("Failed to load the ad")),
                    controller: _nativeAdController,
                    // controller: _nativeAdController,
                    adUnitID: AdsIds.nativeAdsId,
                    numberAds: 1,
                    type: NativeAdmobType.full,
                  ),
                ),
              ),
              //
              // SizedBox(
              //   height: 30,
              // ),
              Text(
                'Rate',
                style: TextStyle(fontSize: 20),
              ),
              RatingBarWidget(),
              SizedBox(
                height: 5,
              ),
              NavigationContainerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
