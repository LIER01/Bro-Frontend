import 'package:bro/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bro/views/course/alternative.dart' as alt;

class AlternativeContainer extends StatefulWidget {
  AlternativeContainer({
    Key? key,
    required this.course,
    required this.alternatives,
    required this.name,
    required this.isAnswer,
    this.answerId,
    required this.clarification,
  }) : super(key: key);
  final Course course;
  final List<Alternative> alternatives;
  final String name;
  final bool isAnswer;
  final int? answerId;
  final String clarification;
  @override
  _AlternativeContainerState createState() => _AlternativeContainerState();
}

class _AlternativeContainerState extends State<AlternativeContainer> {
  bool clicked = false;
  late List<Alternative> alts;
  String? validation;

  @override
  Widget build(BuildContext context) {
    alts = widget.alternatives;
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 20,
        children: List.generate(alts.length, (index) {
          return Container(
              width: (MediaQuery.of(context).size.width - 2 * (2 - 1)) / 2.2,
              child: Align(
                  child: alt.Alternative(
                      widget.course,
                      index,
                      alts[index].alternativeText,
                      alts[index].isCorrect,
                      alts[index].image,
                      widget.isAnswer)));
        }),
      ),
    );
  }
}
