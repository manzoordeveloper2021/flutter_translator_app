import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/constants/enums.dart';
import 'package:office_flutter_translate_app/models/language.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
// enum TtsState { playing, stopped, paused, continued }

class TranslateProvider extends ChangeNotifier {
  TextEditingController textEditingController = TextEditingController();


  GoogleTranslator _translator = new GoogleTranslator();

  String _translatedText = '';
  String get translatedText => _translatedText;

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

  List<Language> searchedList = [];

  searchLanguage(String text) {
    searchedList = languageList
        .where((e) => e.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  clearTextField() {
    this._translatedText = '';
    notifyListeners();
  }

  onTextChanged(String text) {
    if (textEditingController.text != "") {
      _translator
          .translate(textEditingController.text,
              from: this._firstLanguage.code, to: this._secondLanguage.code)
          .then((translatedText) {
        this._translatedText = translatedText.toString();
        notifyListeners();
        // this.setState(() {
        //   this.output = translatedText.toString();
        // });
      });
    } else {
      this._translatedText = translatedText.toString();
      notifyListeners();
      // this.setState(() {
      //   this.output = "";
      // });
    }
  }

  onTextChanged2(String text) {
    if (text != "") {
      _translator
          .translate(text,
              from: this._secondLanguage.code, to: this._firstLanguage.code)
          .then((translatedText) {
        this._translatedText = translatedText.toString();
        notifyListeners();
        // this.setState(() {
        //   this.output = translatedText.toString();
        // });
      });
    } else {
      this._translatedText = translatedText.toString();
      notifyListeners();
      // this.setState(() {
      //   this.output = "";
      // });
    }
  }

  // _speech;

  String _inputText = '';
  bool _isListening = false;

  String get inputText => _inputText;

  bool get isListening => _isListening;

  stt.SpeechToText _speech = stt.SpeechToText();

  setInputString(String value) {
    this._inputText = value;
  }

  setIsListening(bool value) {
    _isListening = value;
    // notifyListeners();
  }

  void listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        // setIsListening(true);
        _speech.listen(onResult: (val) {
          _inputText = val.recognizedWords;
          // setInputString(value);
          notifyListeners();
        }
            //     setState(
            //             () {
            //   _text = val.recognizedWords;
            //   if (val.hasConfidenceRating && val.confidence > 0) {
            //
            //   }
            // }),
            );
      }
    } else {
      setIsListening(false);
      _speech.stop();
      notifyListeners();
    }
  }


  shareText(BuildContext context) {
    if (translatedText.isEmpty) {
      Toast.show('Empty Text is not Allowed...', context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,
        backgroundColor: AppColors.toastErrorColor,
      );
    } else {
      Share.share(translatedText);
    }
  }

  copyTranslatedText(BuildContext context) {
    if (translatedText.isEmpty) {
      Toast.show('Empty Text is not Allowed...', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,
      backgroundColor: AppColors.toastErrorColor,
      );
    } else {
      Clipboard.setData(new ClipboardData(text: translatedText));
      Toast.show("Text copied to clipboard", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;

  initTts() {
    flutterTts = FlutterTts();


    flutterTts.setStartHandler(() {
        ttsState = TtsState.playing;
        print("Playing");
      notifyListeners();
    });

    flutterTts.setCompletionHandler(() {
        print("Complete");
        ttsState = TtsState.stopped;
        notifyListeners();
    });

    flutterTts.setCancelHandler(() {
        print("Cancel");
        ttsState = TtsState.stopped;
        notifyListeners();
    });

    flutterTts.setErrorHandler((msg) {
        print("error: $msg");
        ttsState = TtsState.stopped;
        notifyListeners();
    });
  }


  Future speak(BuildContext context) async {
    String _newVoiceText = '';

    // await flutterTts.setVolume(volume);
    // await flutterTts.setSpeechRate(rate);
    // await flutterTts.setPitch(pitch);

    _newVoiceText =
        translatedText;

    if (_newVoiceText != null && _newVoiceText.isNotEmpty) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(_newVoiceText);
      }
    } else {
      Toast.show('Translate a Text First', context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,
        backgroundColor: AppColors.toastErrorColor,
      );

    }
  }

  Future stop() async {
    var result = await flutterTts.stop();
    // setState(() {
    //   isPlaying = false;
    // });
    if (result == 1) {
      ttsState = TtsState.stopped;
      notifyListeners();
    }
  }

  speakDispose() {
    flutterTts.stop();
  }


  final List<Language> languageList = [
    Language('auto', 'Automatic'),
    Language('af', 'Afrikaans'),
    Language('sq', 'Albanian'),
    Language('am', 'Amharic'),
    Language('ar', 'Arabic'),
    Language('hy', 'Armenian'),
    Language('az', 'Azerbaijani'),
    Language('eu', 'Basque'),
    Language('be', 'Belarusian'),
    Language('bn', 'Bengali'),
    Language('bs', 'Bosnian'),
    Language('bg', 'Bulgarian'),
    Language('ca', 'Catalan'),
    Language('ceb', 'Cebuano'),
    Language('ny', 'Chichewa'),
    Language('zh-cn', 'Chinese Simplified'),
    Language('zh-tw', 'Chinese Traditional'),
    Language('co', 'Corsican'),
    Language('hr', 'Croatian'),
    Language('cs', 'Czech'),
    Language('da', 'Danish'),
    Language('nl', 'Dutch'),
    Language('en', 'English'),
    Language('eo', 'Esperanto'),
    Language('et', 'Estonian'),
    Language('tl', 'Filipino'),
    Language('fi', 'Finnish'),
    Language('fr', 'French'),
    Language('fy', 'Frisian'),
    Language('gl', 'Galician'),
    Language('ka', 'Georgian'),
    Language('de', 'German'),
    Language('el', 'Greek'),
    Language('gu', 'Gujarati'),
    Language('ht', 'Haitian Creole'),
    Language('ha', 'Hausa'),
    Language('haw', 'Hawaiian'),
    Language('iw', 'Hebrew'),
    Language('hi', 'Hindi'),
    Language('hmn', 'Hmong'),
    Language('hu', 'Hungarian'),
    Language('is', 'Icelandic'),
    Language('ig', 'Igbo'),
    Language('id', 'Indonesian'),
    Language('ga', 'Irish'),
    Language('it', 'Italian'),
    Language('ja', 'Japanese'),
    Language('jw', 'Javanese'),
    Language('kn', 'Kannada'),
    Language('kk', 'Kazakh'),
    Language('km', 'Khmer'),
    Language('ko', 'Korean'),
    Language('ku', 'Kurdish (Kurmanji)'),
    Language('ky', 'Kyrgyz'),
    Language('lo', 'Lao'),
    Language('la', 'Latin'),
    Language('lv', 'Latvian'),
    Language('lt', 'Lithuanian'),
    Language('lb', 'Luxembourgish'),
    Language('mk', 'Macedonian'),
    Language('mg', 'Malagasy'),
    Language('ms', 'Malay'),
    Language('ml', 'Malayalam'),
    Language('mt', 'Maltese'),
    Language('mi', 'Maori'),
    Language('mr', 'Marathi'),
    Language('mn', 'Mongolian'),
    Language('my', 'Myanmar (Burmese)'),
    Language('ne', 'Nepali'),
    Language('no', 'Norwegian'),
    Language('ps', 'Pashto'),
    Language('fa', 'Persian'),
    Language('pl', 'Polish'),
    Language('pt', 'Portuguese'),
    Language('ma', 'Punjabi'),
    Language('ro', 'Romanian'),
    Language('ru', 'Russian'),
    Language('sm', 'Samoan'),
    Language('gd', 'Scots Gaelic'),
    Language('sr', 'Serbian'),
    Language('st', 'Sesotho'),
    Language('sn', 'Shona'),
    Language('sd', 'Sindhi'),
    Language('si', 'Sinhala'),
    Language('sk', 'Slovak'),
    Language('sl', 'Slovenian'),
    Language('so', 'Somali'),
    Language('es', 'Spanish'),
    Language('su', 'Sundanese'),
    Language('sw', 'Swahili'),
    Language('sv', 'Swedish'),
    Language('tg', 'Tajik'),
    Language('ta', 'Tamil'),
    Language('te', 'Telugu'),
    Language('th', 'Thai'),
    Language('tr', 'Turkish'),
    Language('uk', 'Ukrainian'),
    Language('ur', 'Urdu'),
    Language('uz', 'Uzbek'),
    Language('vi', 'Vietnamese'),
    Language('cy', 'Welsh'),
    Language('xh', 'Xhosa'),
    Language('yi', 'Yiddish'),
    Language('yo', 'Yoruba'),
    Language('zu', 'Zulu'),
  ];
}
