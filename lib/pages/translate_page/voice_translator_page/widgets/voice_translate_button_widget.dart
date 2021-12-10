import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:office_flutter_translate_app/providers/voice_provider.dart';
import 'package:provider/provider.dart';

class VoiceTranslateButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<VoiceProvider>(
      builder: (context, voiceProvider, child) {
        return

          InkWell(
            onTap: () {
              voiceProvider.translateVoiceText();
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
    );
  }
}
