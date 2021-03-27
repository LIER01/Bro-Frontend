import 'package:bro/blocs/course_detail/course_detail_bloc.dart';
import 'package:bro/blocs/course_detail/course_detail_event.dart';
import 'package:bro/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'alternative_container.dart';

class QuizView extends StatefulWidget {
  QuizView({
    this.course,
    this.questions,
    this.title,
    this.isAnswer,
    this.answerId,
    Key key,
  }) : super(key: key);
  final Course course;
  final String title;
  final List questions;
  final bool isAnswer;
  final int answerId;
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  int index = 0;
  List alts;

  @override
  Widget build(BuildContext context) {
    print(index.toString());
    alts = widget.questions[index]['alternatives'];
    return Column(children: [
      Container(child: Text(widget.questions[index]['question'])),
      Expanded(
          child: Align(
              alignment: Alignment.center,
              child: AlternativeContainer(
                course: widget.course,
                clarification: widget.questions[index]['clarification'],
                name: widget.questions[index]['question'],
                alternatives: widget.isAnswer
                    ? alts.sublist(widget.answerId, widget.answerId + 1)
                    : alts,
                answerId: widget.answerId,
                isAnswer: widget.isAnswer,
              ))),
      Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Text(
              widget.answerId == null
                  ? ''
                  : alts[widget.answerId]['correct']
                      ? 'Korrekt!'
                      : 'Feil!',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: widget.answerId == null
                      ? Colors.red
                      : alts[widget.answerId]['correct']
                          ? Colors.teal
                          : Colors.red))),
      Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 50),
          child: Text(
            widget.isAnswer ? widget.questions[index]['clarification'] : '',
            style: TextStyle(color: Colors.teal),
            textAlign: TextAlign.center,
          )),
      widget.isAnswer
          ? ElevatedButton(
              onPressed: () => {
                    setState(() => {
                          index + 1 < widget.questions.length
                              ? index += 1
                              : print('exit quiz'),
                        }),
                    BlocProvider.of<CourseDetailBloc>(context).add(
                        CourseDetailRequested(
                            course: widget.course,
                            isAnswer: false,
                            isQuiz: true))
                  },
              child: Text(index + 1 < widget.questions.length
                  ? 'Neste Spørsmål'
                  : 'Fullfør quiz'))
          : Container(),
    ]);
  }
}
