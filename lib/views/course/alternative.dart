import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alternative extends StatefulWidget {
  final String name;
  final bool isTrue;
  final int id;
  bool isPressed;
  // This lets us trigger the border color change if it is pressed.
  final LinkedHashMap<String, dynamic> image;

  Alternative(
      this.id, this.name, @required this.isTrue, this.image, this.isPressed);

  @override
  _AlternativeState createState() => _AlternativeState();
}

class _AlternativeState extends State<Alternative> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          debugPrint('triggerd');
          setState(() {
            widget.isPressed = true;
          });
        },
        child: Container(
          width: 50,
          height: 50,
          alignment: FractionalOffset.center,
          decoration: widget.isPressed
              ? BoxDecoration(
                  color: Colors.teal,
                  border: Border.all(
                      color: widget.isTrue ? Colors.green : Colors.red))
              : BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(widget.name),
              )
            ],
          ),
        ));
  }
}