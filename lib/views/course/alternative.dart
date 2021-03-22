import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alternative extends StatefulWidget {
  final String name;
  final bool isTrue;
  // This lets us trigger the border color change if it is pressed.
  final LinkedHashMap<String, dynamic> image;

  Alternative(this.name, @required this.isTrue, this.image);

  @override
  _AlternativeState createState() => _AlternativeState();
}

class _AlternativeState extends State<Alternative> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      color: Colors.white,
      decoration: isPressed
          ? BoxDecoration(
              border:
                  Border.all(color: widget.isTrue ? Colors.green : Colors.red))
          : BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              isPressed = true;
            },
          )
        ],
      ),
    );
  }
}
