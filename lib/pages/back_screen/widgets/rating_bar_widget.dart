import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class RatingBarWidget extends StatelessWidget {
  IconData _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBar.builder(
        initialRating: 2,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        unratedColor: Colors.amber.withAlpha(50),
        itemCount: 5,
        itemSize: 50.0,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          _selectedIcon ?? Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {

          final AndroidIntent intent = AndroidIntent(
              action: 'action_view',
              data: Uri.encodeFull(
                  "https://play.google.com/store/apps/details?id=com.skipeapps.translate.alllanguagetranslator.speaktranslate.cameratranslator&hl=en"),
              package:
              "com.skipeapps.translate.alllanguagetranslator.speaktranslate.cameratranslator");
          intent.launch();
        },
        updateOnDrag: true,
      ),
    );
  }
}
