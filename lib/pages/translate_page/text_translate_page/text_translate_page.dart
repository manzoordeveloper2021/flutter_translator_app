
import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/enums.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/pages/widgets/common_button_widget.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:provider/provider.dart';

import 'choose_language.dart';
import 'widgets/show_translated_text_Container.dart';
import 'widgets/text_field_widget.dart';
import 'widgets/translate_button_widget.dart';


class TextTranslatePage extends StatefulWidget {
  @override
  _TextTranslatePageState createState() => _TextTranslatePageState();
}

class _TextTranslatePageState extends State<TextTranslatePage> {

  @override
  void initState() {
    Provider.of<TranslateProvider>(context,listen: false).
    initTts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                    SizedBox(height: 10,),
                    TextFieldWidget(),
                    SizedBox(height: 10,),
                    ChooseLanguage(),
                    SizedBox(height: 10,),
                    TranslateButtonWidget(),
                    SizedBox(height: 10,),
                    ShowTranslatedTextContainer(),
                  ],
                ),
              ),
            ),
            Container(
              height: 70,
              child:
                  Consumer<TranslateProvider>(builder: (context, trans, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonButtonWidget(
                        iconPath: Strings.copyButtonIcon,
                        onTap: () => trans.copyTranslatedText(context)),
                    CommonButtonWidget(
                        iconPath:
                        trans.ttsState == TtsState.playing ? Strings.speakClickButtonIcon : Strings.speakButtonIcon,
                        // Strings.speakButtonIcon,
                        onTap: () => trans.ttsState == TtsState.playing ? trans.stop() : trans.speak(context)),
                    CommonButtonWidget(
                        iconPath: Strings.shareButtonIcon,
                        onTap: () => trans.shareText(context)),
                    CommonButtonWidget(
                        iconPath: Strings.clearTextButtonIcon,
                        onTap: () => trans.clearTextField()),

                  ],
                );
              }),
            ),
          ],
        ),
      );
  }

}
