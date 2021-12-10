import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/providers/currency_converter_provider.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConvertedCurrencyTextFieldWidget extends StatelessWidget {

  TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 145,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: AppColors.textContainerBgColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(5, 5), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: Consumer<CurrencyConverterProvider>(
              builder: (context, currencyProvider, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child:

                  ListTile(
                    title: Text(

                      '${currencyProvider.output +
                      currencyProvider.
                      bottomSelectedCurrencySymbol}',
                      style: TextStyle(color: Colors.black, fontSize: 25

                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      '${currencyProvider.bottomSelectedCurrencyCode}',
                      textAlign: TextAlign.center,

                    ),
                  ),

                );
              },
            )

        ),
      ),
    );
  }
}
