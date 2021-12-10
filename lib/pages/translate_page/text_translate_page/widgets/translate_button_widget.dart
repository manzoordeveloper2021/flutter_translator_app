import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:provider/provider.dart';

class TranslateButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Consumer<TranslateProvider>(
        builder: (context, trans, child) {
          return

            InkWell(
              onTap: () {
                trans.onTextChanged('');
              },
              child:
              Container(
                height: 50,
                width: width,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                        AssetImage(Strings.textTranslateButton),
                        fit: BoxFit.contain)),
              ),
            );

        },
      ),
    );
  }
}
