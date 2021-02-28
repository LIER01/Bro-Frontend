import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget createWidgetForTesting({Widget child}) {
  return MaterialApp(
    home: child,
  );
}