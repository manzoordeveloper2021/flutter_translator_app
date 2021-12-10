import 'package:flutter/foundation.dart';

class Country {
  final String countryName;
  final String code;

  Country({this.countryName, this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryName: json['Name'],
      code: json['Code'],
    );
  }
}
