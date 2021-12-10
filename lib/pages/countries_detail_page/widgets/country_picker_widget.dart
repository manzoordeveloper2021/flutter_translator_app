import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/providers/country_details_provider.dart';
import 'package:provider/provider.dart';


class CountryPickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      margin: EdgeInsets.only(bottom: 20, top: 10),
      // decoration: BoxDecoration(
      //   // color: AppColors.tapBarUnSelectedButtonColor,
      //   color: Colors.brown,
      //   borderRadius: BorderRadius.circular(20),
      // ),
      decoration: BoxDecoration(
        // color: AppColors.textContainerBgColor,
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(5, 5), // changes position of shadow
          ),
        ],
      ),
      child: CountryListPick(
        initialSelection: '+92',
        onChanged: (CountryCode code) {
          print(code.name);
          // print(code.code);
          // print(code.dialCode);
          // print(code.flagUri);

          Provider.of<CountryDetailsProvider>(context, listen: false)
              .getCountry(code.name);
        },
        theme: CountryTheme(
          isShowFlag: true,
          isShowTitle: true,
          isShowCode: true,
          isDownIcon: true,
          showEnglishName: true,
        ),
      ),
    );
  }
}
