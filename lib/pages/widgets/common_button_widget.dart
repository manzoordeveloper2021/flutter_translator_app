import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {

  final String iconPath;
  final Function onTap;

  const CommonButtonWidget({Key key, this.iconPath, this.onTap}) : super(key: key);

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
