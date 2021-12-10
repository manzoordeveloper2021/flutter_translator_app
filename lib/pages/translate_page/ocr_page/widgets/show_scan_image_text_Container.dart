import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/providers/ocr_provider.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:office_flutter_translate_app/providers/voice_provider.dart';
import 'package:provider/provider.dart';

class ShowScanImageTextContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<OcrProvider>(
      builder: (context, ocrProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Container(
              height: 145,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: AppColors.textContainerBgColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(5, 5), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Text(
                  ocrProvider.inputText == null ? " " : ocrProvider.inputText,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  // maxLines: 15,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
