import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/pages/currency_converter_page/widgets/second_country_list_screen.dart';
import 'package:office_flutter_translate_app/providers/currency_converter_provider.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart' as transition;

import 'first_country_list_screen.dart';

class ChooseCountryCurrency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyConverterProvider>(
      builder: (context, currencyProvider, child) {
        return Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0),
            child: Row(
              children: <Widget>[
                FirstCountryCurrencyWidget(),
                CenterIcon(),
                SecondCountryCurrencyWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FirstCountryCurrencyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyConverterProvider>(
        builder: (context, currencyProvider, child) {
      return Expanded(
        flex: 2,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.chooseLanguageButtonColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () async {
              // var selectedCurrency = await
              Navigator.push(
                context,
                transition.PageTransition(
                  type: transition.PageTransitionType.rightToLeft,
                  child: FirstCountryListScreen(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  // width: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: AutoSizeText(
                      // '${currencyProvider.firstCountryCurrency == null ? currencyNameList[0] : currencyProvider.firstCountryCurrency.currencyName}',
                      '${currencyProvider.topSelectedCurrencyName}',
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
    });
  }
}

class CenterIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
      ImageIcon(AssetImage(Strings.textConvertIcon),size: 40,),
    );
  }
}


class SecondCountryCurrencyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyConverterProvider>(
        builder: (context, currencyProvider, child) {
      return
        Expanded(
          flex: 2,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.chooseLanguageButtonColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () async {
                // var selectedCurrency = await
                Navigator.push(
                  context,
                  transition.PageTransition(
                    type: transition.PageTransitionType.rightToLeft,
                    child: SecondCountryListScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    // width: 120,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: AutoSizeText(
                        // '${currencyProvider.secondCountryCurrency == null ? currencyNameList[1] : currencyProvider.secondCountryCurrency.currencyName}',
                        '${currencyProvider.bottomSelectedCurrencyName}',
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
    });
  }
}
