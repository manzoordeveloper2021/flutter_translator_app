import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';


class TravelGuideHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.blue,
        child: Image.asset(Strings.travel_guide_screen_bg,fit: BoxFit.cover,)
      );
  }
}
