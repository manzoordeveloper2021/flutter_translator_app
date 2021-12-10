import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onClick;
  final String pageName;

  const GlobalButton(
      {Key key, this.title, this.icon, this.onClick, this.pageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 230,
      decoration: BoxDecoration(
        color: Color(0xFF0D47A1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, pageName);
        },
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
