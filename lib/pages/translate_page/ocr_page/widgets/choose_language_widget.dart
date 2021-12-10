import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/pages/translate_page/text_translate_page/language_page.dart';
import 'package:office_flutter_translate_app/providers/ocr_provider.dart';
import 'package:provider/provider.dart';

class ChooseLanguageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    Consumer<OcrProvider>(
      builder: (context,ocrProvider,child) {
        return
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
                    ocrProvider.changeSecondLanguage(language);
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
                          '${ocrProvider.secondLanguage.name}',
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
          );
        //   Container(
        //   height: 50,
        //   decoration: BoxDecoration(
        //     color: Color(0xFF0D47A1),
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: InkWell(
        //     onTap: () async {
        //       final language = await Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => LanguagePage(
        //             title: 'Translate To',
        //             isAutomaticEnabled: false,
        //           ),
        //         ),
        //       );
        //
        //       if (language != null) {
        //         ocrProvider.changeSecondLanguage(language);
        //       }
        //     },
        //     child:
        //     Row(
        //       mainAxisAlignment:
        //       MainAxisAlignment.spaceEvenly,
        //       children: [
        //         Text(
        //           ocrProvider.secondLanguage.name,
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 15.0,
        //           ),
        //         ),
        //         Icon(Icons.arrow_drop_down,color: Colors.black,)
        //       ],
        //     ),
        //   ),
        // );
      },
    );

  }
}
