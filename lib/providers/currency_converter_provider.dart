import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/constants/lists.dart';
import 'package:office_flutter_translate_app/models/country_currency.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';

class CurrencyConverterProvider extends ChangeNotifier {
  String output = '';

  double preDefinedAmount = 00.00;
  double finalResult;

  // Pre selected currency info for top part
  String topSelectedCurrencyName = currencyNameList[6];
  String topSelectedCurrencyCode = currencyCodeList[6];
  String topSelectedCurrencySymbol = currencySymbolList[6];

// Pre selected currency info for bottom part
  String bottomSelectedCurrencyName = currencyNameList[85];
  String bottomSelectedCurrencyCode = currencyCodeList[85];
  String bottomSelectedCurrencySymbol = currencySymbolList[85];

  setFirstCountyCurrencyDetails(int index) {
    topSelectedCurrencyName = currencyNameList[index];
    topSelectedCurrencyCode = currencyCodeList[index];
    topSelectedCurrencySymbol = currencySymbolList[index];
    notifyListeners();
  }

  CountryCurrency secondCountryCurrency;

  setSecondCountyCurrencyDetails(int index) {
    bottomSelectedCurrencyName = currencyNameList[index];
    bottomSelectedCurrencyCode = currencyCodeList[index];
    bottomSelectedCurrencySymbol = currencySymbolList[index];
    notifyListeners();
  }

  // To show http error status code in the error screen if response code != 200.
  int httpStatusCode;

  // To show requested currency in the error screen if response code != 200.
  String requestCurrency;

  setPreDefineAmount(String value) {
    preDefinedAmount = double.parse(value);
    updateUI();
    // notifyListeners();
  }

  void updateUI() async {
    try {
      double exchangeRate = await requestExchangeRate();

      finalResult = exchangeRate * preDefinedAmount;
      output = finalResult.toStringAsFixed(2);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<double> requestExchangeRate() async {
    double exchangeRate;

    // Used try-catch block to catch internet connectivity related exception.

    try {
      http.Response response =
          await http.get('https://free.currconv.com/api/v7/convert?q='
              '${topSelectedCurrencyCode}_'
              '$bottomSelectedCurrencyCode'
              '&compact=ultra&apiKey=2403a9dd5eeeb59060c2');

      requestCurrency =
          '${topSelectedCurrencyCode}_$bottomSelectedCurrencyCode';

      if (response.statusCode == 200) {
        exchangeRate = double.parse((jsonDecode(response.body)[
                '${topSelectedCurrencyCode}_$bottomSelectedCurrencyCode'])
            .toString());
      } else {
        httpStatusCode = response.statusCode;
        print(httpStatusCode);
        final snackBar = SnackBar(
          content: Text('An unexpected error occurred.'),
          duration: Duration(hours: 24),
          action: SnackBarAction(
              label: 'See details',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ErrorScreen(
                //       errorStatusCode: httpStatusCode,
                //       requestUrl: requestCurrency,
                //     ),
                //   ),
                // );
              }),
        );
        // _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    } on SocketException catch (_) {
      final exceptionSnackBar = SnackBar(
        content: Text('Looks like your internet connection is not stable.'),
      );
      // Future.delayed(Duration(seconds: 3), () {
      //   _scaffoldKey.currentState.showSnackBar(exceptionSnackBar);
      // });
    }
    return exchangeRate;
  }



  copyAmount(BuildContext context) {

    String copyText = '$output  $bottomSelectedCurrencySymbol';

    if (copyText.isEmpty) {
      Toast.show('Empty Text is not Allowed...', context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,
        backgroundColor: AppColors.toastErrorColor,
      );
    } else {
      Clipboard.setData(new ClipboardData(text: copyText));
      Toast.show("Text copied to clipboard", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }


  shareAmount(BuildContext context) {
    String shareText = '$output  $bottomSelectedCurrencySymbol';

    if (shareText.isEmpty) {
      Toast.show('Empty Text is not Allowed...', context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,
        backgroundColor: AppColors.toastErrorColor,
      );
    } else {
      Share.share(shareText);
    }
  }



}
