import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import 'choose_language.dart';
import '../models/language.dart';

class TextTranslatePage2 extends StatefulWidget {

  @override
  _TextTranslatePage2State createState() => _TextTranslatePage2State();
}

class _TextTranslatePage2State extends State<TextTranslatePage2> {
  TextEditingController textEditingController = TextEditingController();

  String output = "";

  GoogleTranslator _translator = new GoogleTranslator();

  Language _firstLanguage = Language('en', 'English');

  Language _secondLanguage = Language('fr', 'French');

  _onLanguageChanged(Language firstCode, Language secondCode) {
    this.setState(() {
      this._firstLanguage = firstCode;
      this._secondLanguage = secondCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Translate Page'),),
    body: Container(
      child: Column(
        children: [
          ChooseLanguage(
            onLanguageChanged: this._onLanguageChanged,
          ),
        ],
      ),
    ),
    );
  }
}
