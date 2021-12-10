import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/pages/currency_converter_page/currency_converter_home_screen.dart';
import 'package:office_flutter_translate_app/pages/travel_guide_page/travel_guide_home_page.dart';
import 'package:office_flutter_translate_app/pages/widgets/banner_ads_container.dart';
import 'package:office_flutter_translate_app/providers/ads_provider.dart';
import 'package:provider/provider.dart';

import 'countries_detail_home_page.dart';
import 'package:admob_flutter/admob_flutter.dart';

class CountryHomePage extends StatefulWidget {
  static const String ROUTE_NAME = '/country_home_page';

  @override
  _CountryHomePageState createState() => _CountryHomePageState();
}

class _CountryHomePageState extends State<CountryHomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AdmobBannerSize bannerSize;

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);

    // int.parse(MediaQuery.of(context).size.width.toString())

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  final _nativeAdController = NativeAdmobController();

  bool value = false;

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    bannerSize = AdmobBannerSize.ADAPTIVE_BANNER(
      width: MediaQuery.of(context).size.width.toInt() -
          0, // considering EdgeInsets.all(20.0)
    );

    final adsProvider = Provider.of<AdsProvider>(context);
    adsProvider.setScreenContext(context);
    return WillPopScope(
      onWillPop: () {
        adsProvider.backScreen();
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Country Details Screen'),
        ),
        // drawer:
        key: _scaffoldKey,

        body: value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 05),
                      margin: const EdgeInsets.only(top: 0),
                      width: pageWidth - 0,
                      decoration: BoxDecoration(
                        color: AppColors.tapBarUnSelectedButtonColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TabBar(
                          onTap: (index) {},
                          controller: _tabController,
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: false,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.tapBarSelectedButtonColor),
                          tabs: [
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Country Details')),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Currency Converter')),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Travel Guide')),
                          ]),
                    ),
                  ),
                  Expanded(
                    flex: 08,
                    // height: pageHeight,
                    child: TabBarView(controller: _tabController, children: [
                      CountriesDetailPage(),
                      CurrencyConverterHomeScreen(),
                      TravelGuideHomePage(),
                    ]),
                  ),
                  Container(
                    // margin: EdgeInsets.only(bottom: 20.0),
                    child: AdmobBanner(
                      adUnitId: AdsIds.bannerAdsId,
                      adSize: bannerSize,
                      listener:
                          (AdmobAdEvent event, Map<String, dynamic> args) {
                        // handleEvent(event, args, 'Banner');
                      },
                      onBannerCreated: (AdmobBannerController controller) {
                        // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                        // Normally you don't need to worry about disposing this yourself, it's handled.
                        // If you need direct access to dispose, this is your guy!
                        // controller.dispose();
                      },
                    ),
                  ),
                  // Container(
                  //   height: 120,
                  //   // height: 330,
                  //   width: MediaQuery.of(context).size.width,
                  //   padding: EdgeInsets.all(10),
                  //
                  //   margin: EdgeInsets.all(10.0),
                  //
                  //   decoration: BoxDecoration(
                  //       color: Color(0xff2ba6de),
                  //       border: Border.all(width: 1, color: Color(0xfff2ba6de)),
                  //       borderRadius: BorderRadius.all(Radius.circular(10))),
                  //
                  //   child: NativeAdmob(
                  //     // Your ad unit id
                  //     options: NativeAdmobOptions(
                  //       //ad button
                  //       callToActionStyle: NativeTextStyle(
                  //           fontSize: 15,
                  //           color: Colors.white,
                  //           backgroundColor: Color(0xFFde632b)),
                  //
                  //       adLabelTextStyle: NativeTextStyle(
                  //
                  //         color: Colors.white,
                  //         // backgroundColor: Color(0xFF4CBE99)
                  //       ),
                  //       headlineTextStyle:
                  //       NativeTextStyle( color: Colors.white),
                  //       bodyTextStyle:
                  //       NativeTextStyle( color: Colors.white),
                  //       advertiserTextStyle:
                  //       NativeTextStyle( color: Colors.white),
                  //       storeTextStyle:
                  //       NativeTextStyle( color: Colors.red),
                  //     ),
                  //     loading: Center(child: Container()),
                  //     error: Center(child: Text("Failed to load the ad")),
                  //     controller: _nativeAdController,
                  //     // controller: _nativeAdController,
                  //     adUnitID: AdsIds.nativeAdsId,
                  //     numberAds: 1,
                  //     type: NativeAdmobType.banner,
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }
}
