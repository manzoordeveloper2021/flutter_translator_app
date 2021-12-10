import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/constants/enums.dart';
import 'package:office_flutter_translate_app/models/language.dart';
import 'package:share/share.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:toast/toast.dart';
import 'package:translator/translator.dart';

class VoiceProvider extends ChangeNotifier {

  Language _firstLanguage = Language('en', 'English');

  Language _secondLanguage = Language('fr', 'French');

  // Language get firstLanguage => _firstLanguage;
  updateLanguage(Language firstCode, Language secondCode) {
    this._firstLanguage = firstCode;
    this._secondLanguage = secondCode;
  }

  stt.SpeechToText _speech ;
  bool _isListening = false;

  initVoice() {
    _speech = stt.SpeechToText();
  }

  bool get isListening => _isListening;

  String _text = '';

  String get voiceText => _text;

  listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        _isListening = true;
        notifyListeners();
        _speech.listen(
            localeId: this._firstLanguage.code,
            onResult: (val) {
              _text = val.recognizedWords;
              notifyListeners();
            }

        );
      }
    } else {
      // setState(() => _isListening = false);
      _isListening = false;
      notifyListeners();
      _speech.stop();
    }
  }

  GoogleTranslator _translator = new GoogleTranslator();
  String _translatedText = '';
  String get translatedText => _translatedText;

  translateVoiceText() {
    if (_text != "") {
      _translator
          .translate(_text,
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
        // setState(() {
        //   isPlaying = true;
        // });
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

  clearTextField() {
    this._translatedText = '';
    notifyListeners();
  }




}