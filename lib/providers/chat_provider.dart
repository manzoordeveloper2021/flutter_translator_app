import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:office_flutter_translate_app/constants/enums.dart';
import 'package:office_flutter_translate_app/models/language.dart';
import 'package:office_flutter_translate_app/models/message.dart';
import 'package:office_flutter_translate_app/pages/translate_page/chat/widgets/flat_chat_message.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';
class ChatProvider extends ChangeNotifier {

  List<Message> messages = [
  ];

  Language _firstLanguage;
  Language _secondLanguage;


  updateLanguage(Language firstCode, Language secondCode) {
    this._firstLanguage = firstCode;
    this._secondLanguage = secondCode;
  }

  GoogleTranslator _translator = new GoogleTranslator();
  String _translatedText = '';
  String get translatedText => _translatedText;

  chat1() {
    listen1();
    print('speak Text : $_text');
    addToMessage();
  }
  listen1() async {
    if (!_isListening1) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        _isListening1 = true;
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
      // setState(() => _isListening1 = false);
      _isListening1 = false;
      notifyListeners();
      _speech.stop();
    }
  }
  addToMessage() {
    if (_text.isNotEmpty) {
      messages.add(
        Message(
          message: _text,
          messageType: MessageType.received,
          time: DateFormat.jm().format(DateTime.now()),
          showTime: true,
        ),
      );
      notifyListeners();

      translateVoiceText();
      Future.delayed(Duration(seconds: 2), () {
        messages.removeLast();
        messages.add(
          Message(
            message:
            translatedText,
            messageType: MessageType.sent,
            time: DateFormat.jm().format(DateTime.now()),
            showTime: true,
          ),
        );

        _text = '';
        notifyListeners();
      });
      Future.delayed(Duration(seconds: 2), () {
        ttsState == TtsState.playing ? stop() : speak();
        // speak();
      });
    } else {
      return;
    }
    _speech.stop();
  }
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

  Future speak() async {
    String _newVoiceText = '';

    // await flutterTts.setVolume(volume);
    // await flutterTts.setSpeechRate(rate);
    // await flutterTts.setPitch(pitch);

    _newVoiceText =
        _translatedText;

    if (_newVoiceText != null && _newVoiceText.isNotEmpty) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(_newVoiceText);
        print('TRanslated Text : $_translatedText}');
        // setState(() {
        //   isPlaying = true;
        // });
      }
    } else {
      print('Speak Error');

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


  stt.SpeechToText _speech;
  bool _isListening1 = false;
  bool get isListening1 => _isListening1;
  String _text = '';

  initVoice() {
    _speech = stt.SpeechToText();
  }

  bool _isListening2 = false;
  bool get isListening2 => _isListening2;
  listen2() async {
    if (!_isListening2) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        _isListening2 = true;
        notifyListeners();
        _speech.listen(
            localeId: this._secondLanguage.code,
            onResult: (val) {
              _text = val.recognizedWords;
              notifyListeners();
            }

        );
      }
    } else {
      // setState(() => _isListening1 = false);
      _isListening2 = false;
      notifyListeners();
      _speech.stop();
    }
  }
  addToMessage2() {
    if (_text.isNotEmpty) {
      messages.add(
        Message(
          message: _text,
          messageType: MessageType.sent,
          time: DateFormat.jm().format(DateTime.now()),
          showTime: true,
        ),
      );
      notifyListeners();

      translateVoiceText2();
      Future.delayed(Duration(seconds: 2), () {
        messages.removeLast();
        messages.add(
          Message(
            message:
            translatedText,
            messageType: MessageType.received,
            time: DateFormat.jm().format(DateTime.now()),
            showTime: true,
          ),
        );

        _text = '';
        notifyListeners();
      });
      Future.delayed(Duration(seconds: 2), () {
        speak();
      });
    } else {
      return;
    }
    _speech.stop();
  }
  translateVoiceText2() {
    if (_text != "") {
      _translator
          .translate(_text,
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


  chat2() {
    listen2();
    print('speak Text : $_text');
    addToMessage2();
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
  speakDispose() {
    flutterTts.stop();
  }



  }


