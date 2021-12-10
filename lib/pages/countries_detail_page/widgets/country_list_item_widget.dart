import 'package:flutter/material.dart';

class CountryListItemWidget extends StatelessWidget {
  final String title;
  final List<String> list;

  const CountryListItemWidget(this.title, this.list);
  @override
  Widget build(BuildContext context) {
    return list == null || list.isEmpty ?  SizedBox.shrink()
        : Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
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
                  child: Container(
                    child: Wrap(
                      children: list.map((e) {
                        if (list.last != e) {
                          e = "$e, ";
                        }

                        return Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(e ?? ""),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
