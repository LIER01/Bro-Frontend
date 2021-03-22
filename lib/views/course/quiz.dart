import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'alternative_container.dart';

class QuizView extends StatefulWidget {
  QuizView({
    this.questions,
    this.title,
    this.isAnswer,
    this.answerId,
    Key key,
  }) : super(key: key);
  final String title;
  final List questions;
  final bool isAnswer;
  final int answerId;
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final int index = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.questions[index]['alternatives']);
    return Text("Test");
    // return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //   Container(height: 300, child: Text(widget.questions[index]['question'])),
    //   AlternativeContainer(
    //       name: widget.questions[index]['question'],
    //       alternatives: widget.questions[index]['alternatives']),
    // ]);
  }
}
