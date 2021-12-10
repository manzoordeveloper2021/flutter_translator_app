import 'package:flutter/material.dart';

class DrawerButtonWidget extends StatelessWidget {

  final String title;
  final String iconPath;
  final Function onTap;

  const DrawerButtonWidget({Key key, this.title, this.iconPath, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: ImageIcon(
        AssetImage(iconPath),
        size: 30,
        color: Colors.black,
      ),
      title: Text(title,style: TextStyle(color: Colors.black54,fontSize: 14),),
    );
  }
}
