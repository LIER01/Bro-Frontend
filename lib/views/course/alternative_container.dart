import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'alternative.dart';

class AlternativeContainer extends StatefulWidget {
  AlternativeContainer({Key key, this.alternatives, this.name})
      : super(key: key);
  final List alternatives;
  final String name;
  @override
  _AlternativeContainerState createState() => _AlternativeContainerState();
}

class _AlternativeContainerState extends State<AlternativeContainer> {
  @override
  Widget build(BuildContext context) {
    //print(widget.question['question']);
    return Expanded(
      child: GridView.count(
        //2 columns
        crossAxisCount: 2,
        children: List.generate(widget.alternatives.length, (index) {
          return /* Center(child: Text(widget.alternatives[index]['name']) */
              Alternative(
                  widget.alternatives[index]['name'],
                  widget.alternatives[index]['correct'],
                  widget.alternatives[index]['image']);
        }),
      ),
    );
  }
}
