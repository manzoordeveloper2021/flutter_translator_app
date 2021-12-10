import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/providers/ads_provider.dart';
import 'package:provider/provider.dart';


class NavigationContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adsProvider = Provider.of<AdsProvider>(context);
    adsProvider.setScreenContext(context);
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              iconSize: 120,
              icon: Image.asset(Strings.noButtonIcon),
              onPressed: () {
                // Navigator.of(context).pop();
                adsProvider.backScreen();
              }),
          IconButton(
              iconSize: 120,
              icon: Image.asset(Strings.yesButtonIcon),
              onPressed: () {
                // SystemChannels.platform
                //     .invokeMethod('SystemNavigator.pop');

                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }),
        ],
      ),
    );
  }
}
