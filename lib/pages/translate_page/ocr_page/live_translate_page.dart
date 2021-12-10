import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';
import 'package:office_flutter_translate_app/constants/enums.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/pages/widgets/large_native_banner_container.dart';
import 'package:office_flutter_translate_app/pages/widgets/medium_native_banner_container.dart';
import 'package:office_flutter_translate_app/pages/widgets/banner_ads_container.dart';
import 'package:office_flutter_translate_app/providers/ads_provider.dart';
import 'package:office_flutter_translate_app/providers/ocr_provider.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../text_translate_page/language_page.dart';
import 'widgets/choose_language_widget.dart';
import 'widgets/ocr_translate_bottom_button_widget.dart';
import 'widgets/ocr_translate_button_widget.dart';
import 'widgets/show_scan_image_text_Container.dart';
import 'widgets/show_translated_image_text_Container.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class LiveTranslatePage extends StatefulWidget {
  static const String ROUTE_NAME = '/live_translate_page';

  @override
  _LiveTranslatePageState createState() => _LiveTranslatePageState();
}

class _LiveTranslatePageState extends State<LiveTranslatePage> {
  TextEditingController textEditingController = TextEditingController();
  final _nativeAdController = NativeAdmobController();

  @override
  void initState() {
    Provider.of<OcrProvider>(context, listen: false).initTts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    final ocrProvider = Provider.of<OcrProvider>(context);
    final adsProvider = Provider.of<AdsProvider>(context);
    adsProvider.setScreenContext(context);
    return WillPopScope(
      onWillPop: () {
        adsProvider.backScreen();
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(' Translate'),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Strings.text_translator_page_bg),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              // SmallNativeBannerContainer(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ShowScanImageTextContainer(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ChooseLanguageWidget(),
                            SizedBox(
                              width: 10,
                            ),
                            OcrTranslateButtonWidget(),
                          ],
                        ),
                      ),
                      ShowTranslatedImageTextContainer(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OcrTranslateBottomButtonWidget(
                                iconPath: Strings.copyButtonIcon,
                                onTap: () =>
                                    ocrProvider.copyTranslatedText(context)),
                            OcrTranslateBottomButtonWidget(
                                iconPath: ocrProvider.ttsState == TtsState.playing
                                    ? Strings.speakClickButtonIcon
                                    : Strings.speakButtonIcon,
                                onTap: () =>
                                    ocrProvider.ttsState == TtsState.playing
                                        ? ocrProvider.stop()
                                        : ocrProvider.speak(context)),
                            OcrTranslateBottomButtonWidget(
                                iconPath: Strings.shareButtonIcon,
                                onTap: () => ocrProvider.shareText(context)),
                            OcrTranslateBottomButtonWidget(
                                iconPath: Strings.clearTextButtonIcon,
                                onTap: () => ocrProvider.clearTextField()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // height: 280,
                height: 120,
                width: MediaQuery.of(context).size.width,

                padding: EdgeInsets.all(10),

                margin: EdgeInsets.all(10.0),

                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color(0xfff2ba6de)),
                    borderRadius: BorderRadius.all(Radius.circular(30))),

                child: NativeAdmob(
                  // Your ad unit id
                  loading: Center(child: Container()),
                  error: Center(child: Text("Failed to load the ad")),
                  controller: _nativeAdController,
                  // controller: _nativeAdController,
                  adUnitID: AdsIds.nativeAdsId,
                  numberAds: 1,
                  type: NativeAdmobType.banner,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
