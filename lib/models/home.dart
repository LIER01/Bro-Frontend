import 'package:flutter/foundation.dart';

class Home {
  Home({required this.header, required this.introduction});
  final String header;
  final String introduction;

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      header: json['header'],
      introduction: json['introduction'],
    );
  }
}
