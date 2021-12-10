import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/providers/ads_provider.dart';
import 'package:provider/provider.dart';

class DictionaryHomePage extends StatelessWidget {
  static const String ROUTE_NAME = '/dictionary_home_page';

  @override
  Widget build(BuildContext context) {
    // final adsProvider = Provider.of<AdsProvider>(context);
    // adsProvider.setScreenContext(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Dictionary'),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.blue,
            child: Image.asset(
              Strings.dictionary_screen_bg,
              fit: BoxFit.cover,
            )));
  }
}
