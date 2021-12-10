import 'package:flutter/material.dart';

class VoiceTranslateBottomButtonWidget extends StatelessWidget {

  final String iconPath;
  final Function onTap;

  const VoiceTranslateBottomButtonWidget({Key key, this.iconPath, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      IconButton(
      iconSize: 70,
        // tooltip: 'Copy',
        icon: Image.asset(iconPath),
      onPressed: onTap,
    );
  }
}
