import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/pages/currency_converter_page/widgets/choose_country_currency.dart';
import 'package:office_flutter_translate_app/pages/currency_converter_page/widgets/converted_currency_text_field_widget.dart';
import 'package:office_flutter_translate_app/pages/currency_converter_page/widgets/currency_converter_text_field_widget.dart';
import 'package:office_flutter_translate_app/providers/currency_converter_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/currency_converter_bottom_button_widget.dart';

class CurrencyConverterHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Strings.text_translator_page_bg),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                CurrencyConverterTextFieldWidget(),
                SizedBox(height: 10,),
                ChooseCountryCurrency(),
                SizedBox(height: 10,),

                ConvertedCurrencyTextFieldWidget(),
              ],
            ),
          )),
          Container(
            height: 70,
            child:
            Consumer<CurrencyConverterProvider>(builder: (context, currencyProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CurrencyConverterBottomButtonWidget(
                      iconPath: Strings.copyButtonIcon,
                      onTap: () => currencyProvider.copyAmount(context)),

                  CurrencyConverterBottomButtonWidget(
                      iconPath: Strings.shareButtonIcon,
                      onTap: () => currencyProvider.shareAmount(context)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
