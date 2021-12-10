import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/providers/ocr_provider.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:provider/provider.dart';

class OcrTranslateButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Consumer<OcrProvider>(
          builder: (context, ocrProvider, child) {
            return

              InkWell(
                onTap: () {
                  ocrProvider.translateImageText();
                },
                child:
                Container(
                  height: 50,
                  width: width,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          AssetImage(Strings.translateButton),
                          fit: BoxFit.contain)),
                ),
              );

          },
        ),
      ),
    );
  }
}
