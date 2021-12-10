import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/pages/translate_page/ocr_page/live_translate_page.dart';
import 'package:office_flutter_translate_app/pages/widgets/global_button.dart';
import 'package:office_flutter_translate_app/pages/widgets/large_native_banner_container.dart';
import 'package:office_flutter_translate_app/providers/ocr_provider.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/ocr_main_screen_button_widget.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class OcrHomePage extends StatelessWidget {
  // static const _adUnitID = "ca-app-pub-3940256099942544/8135179316";

  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    final ocrProvider = Provider.of<OcrProvider>(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Strings.text_translator_page_bg),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: Container(
              // height: 100,
              // color: Colors.grey,
              padding: EdgeInsets.only(top: 30),

              child: ListView(
                children: [
                  OcrMainScreenButtonWidget(
                    iconPath: Strings.ocrScreenButton2,
                    onTap: () async {
                      ocrProvider.takeImage();
                      Navigator.pushNamed(
                          context, LiveTranslatePage.ROUTE_NAME);
                    },
                  ),
                  OcrMainScreenButtonWidget(
                    iconPath: Strings.ocrScreenButton1,
                    onTap: () async {
                      ocrProvider.pickImage();
                      Navigator.pushNamed(
                          context, LiveTranslatePage.ROUTE_NAME);
                    },
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
