import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alternative extends StatefulWidget {
  final String name;
  final bool isTrue;
  // This lets us trigger the border color change if it is pressed.
  final LinkedHashMap<String, dynamic> image;

  Alternative(this.name, this.isTrue, this.image);

  @override
  _AlternativeState createState() => _AlternativeState();
}

class _AlternativeState extends State<Alternative> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: isPressed
                      ? widget.isTrue
                          ? Colors.green
                          : Colors.red
                      : Colors.grey)),
          child: Text(widget.name)),
      onTap: () {
        setState(() => isPressed = true);
      },
    );
  }
}
