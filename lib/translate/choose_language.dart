import 'package:flutter/material.dart';


import '../models/language.dart';
import 'language_page.dart';

class ChooseLanguage extends StatefulWidget {
  ChooseLanguage({Key key, this.onLanguageChanged}) : super(key: key);

  final Function(Language firstCode, Language secondCode) onLanguageChanged;

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  Language _firstLanguage = Language('en', 'English');
  Language _secondLanguage = Language('fr', 'French');

  // Switch the first and the second language
  void _switchLanguage() {
    Language _tmpLanguage = this._firstLanguage;

    setState(() {
      this._firstLanguage = this._secondLanguage;
      this._secondLanguage = _tmpLanguage;
    });

    this.widget.onLanguageChanged(this._firstLanguage, this._secondLanguage);
  }

  // Choose a new first language
  void _chooseFirstLanguage(String title, bool isAutomaticEnabled) async {
    final language = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LanguagePage(
          title: title,
          isAutomaticEnabled: isAutomaticEnabled,
        ),
      ),
    );

    if (language != null) {
      this.setState(() {
        this._firstLanguage = language;
      });

      this.widget.onLanguageChanged(this._firstLanguage, this._secondLanguage);
    }
  }

  // Choose a new second language
  void _chooseSecondLanguage(String title, bool isAutomaticEnabled) async {
    final language = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LanguagePage(
          title: title,
          isAutomaticEnabled: isAutomaticEnabled,
        ),
      ),
    );

    if (language != null) {
      this.setState(() {
        this._secondLanguage = language;
      });

      this.widget.onLanguageChanged(this._firstLanguage, this._secondLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom:
              BorderSide(color: Colors.blueAccent, width: 2.0),
              top: BorderSide(color: Colors.blueAccent, width: 2.0),
              right:
              BorderSide(color: Colors.blueAccent, width: 2.0),
              left:
              BorderSide(color: Colors.blueAccent, width: 2.0),
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15,
                  offset: Offset(0.01, 0.04),
                  spreadRadius: 0.5)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      this._chooseFirstLanguage("Translate from", true);
                    },
                    child: Center(
                      child: Text(
                        this._firstLanguage.name,
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.compare_arrows,
                    color: Colors.grey[700],
                  ),
                  onPressed: this._switchLanguage,
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      this._chooseSecondLanguage("Translate to", false);
                    },
                    child: Center(
                      child: Text(
                        this._secondLanguage.name,
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
