import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/pages/translate_page/chat/chatpage.dart';
import 'package:office_flutter_translate_app/pages/translate_page/voice_translator_page/voice_translate_page.dart';
import 'package:office_flutter_translate_app/pages/widgets/banner_ads_container.dart';
import 'package:office_flutter_translate_app/providers/ads_provider.dart';
import 'package:provider/provider.dart';

import 'ocr_page/ocr_home_page.dart';
import 'text_translate_page/text_translate_page.dart';



class TranslateHomePage extends StatefulWidget {
  static const String ROUTE_NAME = '/translate_home_page';

  @override
  _TranslateHomePageState createState() => _TranslateHomePageState();
}

class _TranslateHomePageState extends State<TranslateHomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  bool value = false;
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

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
          title: Text('Translate to any Language'),
        ),
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
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),)
                      ),
                      child: TabBar(
                          onTap: (index) {},
                          controller: _tabController,
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.tapBarSelectedButtonColor),
                          tabs: [
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Translate')),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Voice')),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text('OCR')),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Chat')),
                          ]),
                    ),
                  ),
                  Expanded(
                    flex: 08,
                    // height: pageHeight,
                    child: TabBarView(controller: _tabController, children: [
                      TextTranslatePage(),
                      VoiceTranslatePage(),
                      OcrHomePage(),
                      ChatPage(),
                    ]),
                  ),
                  Container(
                    height: 120,
                    // height: 330,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),

                    margin: EdgeInsets.all(10.0),

                    decoration: BoxDecoration(
                        color: Color(0xff2ba6de),
                        border: Border.all(width: 1, color: Color(0xfff2ba6de)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),

                    child: NativeAdmob(
                      // Your ad unit id
                      options: NativeAdmobOptions(
                        //ad button
                        callToActionStyle: NativeTextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            backgroundColor: Color(0xFFde632b)),

                        adLabelTextStyle: NativeTextStyle(

                          color: Colors.white,
                          // backgroundColor: Color(0xFF4CBE99)
                        ),
                        headlineTextStyle:
                        NativeTextStyle( color: Colors.white),
                        bodyTextStyle:
                        NativeTextStyle( color: Colors.white),
                        advertiserTextStyle:
                        NativeTextStyle( color: Colors.white),
                        storeTextStyle:
                        NativeTextStyle( color: Colors.red),
                      ),
                      loading: Center(child: Container()),
                      error: Center(child: Text("Failed to load the ad")),
                      controller: _nativeAdController,
                      // controller: _nativeAdController,
                      adUnitID: AdsIds.nativeBannerAdsId,
                      numberAds: 1,
                      type: NativeAdmobType.banner,
                    ),
                  ),

                ],
              ),
      ),
    );
  }
}
