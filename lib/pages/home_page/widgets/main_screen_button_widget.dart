import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';

class MainScreenButtonWidget extends StatelessWidget {

  final String iconPath;
  final String screenName;

  const MainScreenButtonWidget({Key key, this.iconPath, this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
      onTap: () {
        Navigator.pushNamed(context, screenName);
      },
      child:
      Container(
        height: 70,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                AssetImage(iconPath),
                fit: BoxFit.contain)),
      ),
    );
  }
}
