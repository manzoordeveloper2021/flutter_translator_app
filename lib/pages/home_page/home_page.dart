import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';
import 'package:office_flutter_translate_app/pages/ads_list_Screen.dart';
import 'package:office_flutter_translate_app/pages/back_screen/back_screen.dart';
import 'package:office_flutter_translate_app/pages/translate_page/translate_home_page.dart';

import '../../constants/strings.dart';
import '../countries_detail_page/country_home_page.dart';
import '../dictionary_page/dictionary_home_page.dart';
import 'widgets/drawer_widget.dart';
import 'widgets/main_screen_button_widget.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class HomePage extends StatelessWidget {
  static const String ROUTE_NAME = '/home_page';
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, BackScreen.ROUTE_NAME);
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Translator Home Page'),
          elevation: 0.0,
        ),
        drawer: DrawerWidget(),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Strings.mainPageBg), fit: BoxFit.cover)),

          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: 250,
                      // width: 400,
                      // color: Colors.brown,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MainScreenButtonWidget(
                              iconPath: Strings.mainScreenButton1,
                              screenName: TranslateHomePage.ROUTE_NAME,
                            ),
                            MainScreenButtonWidget(
                              iconPath: Strings.mainScreenButton2,
                              screenName: CountryHomePage.ROUTE_NAME,
                            ),
                            MainScreenButtonWidget(
                              iconPath: Strings.mainScreenButton3,
                              screenName: DictionaryHomePage.ROUTE_NAME,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                // height: 280,
                height: 330,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),

                margin: EdgeInsets.all(10.0),

                decoration: BoxDecoration(
                    color: Color(0xff2ba6de),
                    border: Border.all(width: 2, color: Color(0xfff2ba6de)),
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

            ],
          ),
        ),
      ),
    );
  }
}
