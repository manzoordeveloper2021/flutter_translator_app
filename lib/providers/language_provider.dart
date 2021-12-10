import 'package:flutter/cupertino.dart';
import 'package:office_flutter_translate_app/models/language.dart';

class LanguageProvider extends ChangeNotifier {
  Language _firstLanguage = Language('en', 'English');

  Language _secondLanguage = Language('fr', 'French');

  Language get firstLanguage => _firstLanguage;

  Language get secondLanguage => _secondLanguage;


  changeFirstLanguage(Language firstCode) {
    this._firstLanguage = firstCode;
    notifyListeners();
  }

  changeSecondLanguage(Language secondCode) {
    this._secondLanguage = secondCode;
    notifyListeners();
  }
}