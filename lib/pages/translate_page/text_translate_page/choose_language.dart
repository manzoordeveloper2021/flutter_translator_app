import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/models/language.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:provider/provider.dart';

import 'language_page.dart';




class ChooseLanguage extends StatefulWidget {

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    final translateProvider = Provider.of<TranslateProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      // height: 70,
      width: MediaQuery.of(context).size.width,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            // flex: 1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.chooseLanguageButtonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () async {
                  // this._chooseFirstLanguage("Translate from", true);
                  final language = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LanguagePage(
                        title: 'Translate From',
                        isAutomaticEnabled: false,
                      ),
                    ),
                  );

                  if (language != null) {

                    translateProvider.changeFirstLanguage(language);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      // width: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child:
                        AutoSizeText(
                          '${translateProvider.firstLanguage.name}',
                          style: TextStyle(color: Colors.black),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down,color: Colors.black,)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child:
            ImageIcon(AssetImage(Strings.textConvertIcon),size: 40,),
          ),
          Expanded(
            // flex: 1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.chooseLanguageButtonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () async {
                  final language = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LanguagePage(
                        title: 'Translate To',
                        isAutomaticEnabled: false ,
                      ),
                    ),
                  );

                  if (language != null) {
                    translateProvider.changeSecondLanguage(language);
                  }

                },
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      // width: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child:
                        AutoSizeText(
                          '${translateProvider.secondLanguage.name}',
                          style: TextStyle(color: Colors.black),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down,color: Colors.black,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
