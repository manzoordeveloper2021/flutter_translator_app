import 'package:flutter/material.dart';

class CountryItemWidget extends StatelessWidget {
  final String text;
  final String value;

  const CountryItemWidget({Key key, this.text, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == 'null' || value == null
        ? SizedBox()
        : Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .typography
                        .dense
                        .button
                        .copyWith(color: Colors.black),
                  ),
                ),
                Text(":  "),
                Expanded(
                  flex: 4,
                  child: Text(
                    value,
                    style: Theme.of(context)
                        .typography
                        .black
                        .bodyText1
                        .copyWith(color: Colors.black.withOpacity(.7)),
                  ),
                )
              ],
            ),
          );
  }
}
