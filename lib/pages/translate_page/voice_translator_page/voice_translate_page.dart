import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/enums.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/pages/translate_page/ocr_page/widgets/speech_button_widget.dart';
import 'package:office_flutter_translate_app/providers/voice_provider.dart';
import 'package:provider/provider.dart';

import '../text_translate_page/choose_language.dart';
import 'widgets/show_voice_text_Container.dart';
import 'widgets/show_voice_translated_text_Container.dart';
import 'widgets/voice_translate_bottom_button_widget.dart';
import 'widgets/voice_translate_button_widget.dart';

class VoiceTranslatePage extends StatefulWidget {
  @override
  _VoiceTranslatePageState createState() => _VoiceTranslatePageState();
}

class _VoiceTranslatePageState extends State<VoiceTranslatePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<VoiceProvider>(context, listen: false).initVoice();
    Provider.of<VoiceProvider>(context, listen: false).initTts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _speech.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Strings.text_translator_page_bg),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ShowVoiceTextContainer(),
                  SizedBox(
                    height: 10,
                  ),
                  ChooseLanguage(),
                  Row(
                    children: <Widget>[
                      Expanded(child: VoiceTranslateButtonWidget()),
                      Expanded(child: SpeechButtonWidget()),
                    ],
                  ),
                  ShowVoiceTranslatedTextContainer(),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            child: Consumer<VoiceProvider>(
                builder: (context, voiceProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  VoiceTranslateBottomButtonWidget(
                      iconPath: Strings.copyButtonIcon,
                      onTap: () => voiceProvider.copyTranslatedText(context)),
                  VoiceTranslateBottomButtonWidget(
                      iconPath: voiceProvider.ttsState == TtsState.playing
                          ? Strings.speakClickButtonIcon
                          : Strings.speakButtonIcon,
                      onTap: () => voiceProvider.ttsState == TtsState.playing
                          ? voiceProvider.stop()
                          : voiceProvider.speak(context)),
                  VoiceTranslateBottomButtonWidget(
                      iconPath: Strings.shareButtonIcon,
                      onTap: () => voiceProvider.shareText(context)),
                  VoiceTranslateBottomButtonWidget(
                      iconPath: Strings.clearTextButtonIcon,
                      onTap: () => voiceProvider.clearTextField()),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
