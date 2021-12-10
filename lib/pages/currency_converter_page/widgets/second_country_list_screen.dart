import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/lists.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/providers/country_currency_provider.dart';
import 'package:office_flutter_translate_app/providers/currency_converter_provider.dart';
import 'package:provider/provider.dart';

class SecondCountryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Strings.text_translator_page_bg),
              fit: BoxFit.cover)),
      child: SafeArea(
          child: Consumer<CurrencyConverterProvider>(
            builder: (context, currencyProvider, child) {
              return
                ListView.builder(
                  // padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        currencyProvider.setSecondCountyCurrencyDetails(index);
                        Navigator.pop(
                          context,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFefefef).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: RichText(
                          text: TextSpan(
                            text: '${currencyNameList[index]} ',
                            style: TextStyle(
                              color: Colors.black,
                              // fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                              fontSize: 20,
                              letterSpacing: 2,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${currencyCodeList[index]}',
                                style: TextStyle(
                                  // color: currencyNameColor.withOpacity(0.5),
                                    color: Colors.blue
                                  // fontSize: SizeConfig.safeBlockHorizontal * 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: currencyNameList.length,
                );
            },
          ),
        ),

    );
  }
}
