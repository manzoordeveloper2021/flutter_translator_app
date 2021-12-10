import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/constants/enums.dart';
import 'package:office_flutter_translate_app/models/language.dart';
import 'package:office_flutter_translate_app/pages/translate_page/ocr_page/api/firebase_ml_api.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:translator/translator.dart';

class OcrProvider extends ChangeNotifier {

  Language _firstLanguage = Language('en', 'English');

  Language _secondLanguage = Language('fr', 'French');


  Language get secondLanguage  => _secondLanguage;

  updateLanguage(Language firstCode, Language secondCode) {
    this._firstLanguage = firstCode;
    this._secondLanguage = secondCode;
  }

  changeSecondLanguage(Language secondCode) {
    this._secondLanguage = secondCode;
    notifyListeners();
  }

  String _inputText = '';

  String get inputText => _inputText;

  takeImage() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        flash: false,
        autoFocus: false,
        multiple: false,
        waitTap: true,
        showText: true,
        // preview: _previewOcr,
        camera: FlutterMobileVision.CAMERA_BACK,
        fps: 2.0,
      );
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }

    setInputString(texts[0].value);

  }



  setInputString(String value) {
    this._inputText = value;
    notifyListeners();
  }

  GoogleTranslator _translator = new GoogleTranslator();
  String _translatedText = '';
  String get translatedText => _translatedText;

  translateImageText() {
    if (_inputText != "") {
      _translator
          .translate(_inputText,
          from: this._firstLanguage.code, to: this._secondLanguage.code)
          .then((translatedText) {
        this._translatedText = translatedText.toString();
        notifyListeners();
      });
    } else {
      this._translatedText = translatedText.toString();
      notifyListeners();
    }
  }

  File _image;

  File get image => _image;

  Future pickImage() async {
    clearTextField();
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file.path));
    scanText();
  }

  void setImage(File newImage) {
    _image = newImage;
    notifyListeners();
  }

  scanText() async {
    final text = await FirebaseMLApi.recogniseText(image);

    setInputString(text);
    notifyListeners();

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
