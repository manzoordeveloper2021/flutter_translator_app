import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';

class OcrMainScreenButtonWidget extends StatelessWidget {
  final String iconPath;
  final Function onTap;

  const OcrMainScreenButtonWidget({Key key, this.iconPath, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(iconPath), fit: BoxFit.contain)),
      ),
    );
  }
}
