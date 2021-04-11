import 'package:bro/blocs/course_detail/course_detail_bloc.dart';
import 'package:bro/blocs/course_detail/course_detail_event.dart';
import 'package:bro/models/course.dart';
import 'package:bro/models/new_course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'alternative_container.dart';

class QuizView extends StatefulWidget {
  QuizView({
    required this.course,
    required this.questions,
    required this.title,
    required this.isAnswer,
    this.answerId,
    Key? key,
  }) : super(key: key);
  final Courses course;
  final String title;
  final List<Questions> questions;
  final bool isAnswer;
  final int? answerId;
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  int index = 0;
  late List<Alternatives> alts;

  @override
  Widget build(BuildContext context) {
    print(index.toString());
    alts = widget.questions[index].alternatives;
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.07),
            child: Text(widget.questions[index].question,
                style: TextStyle(color: Colors.teal, fontSize: 20))),
      ),
      Align(
          child: AlternativeContainer(
        course: widget.course,
        clarification: widget.questions[index].clarification,
        name: widget.questions[index].question,
        alternatives: widget.isAnswer
            ? alts.sublist(widget.answerId!, widget.answerId! + 1)
            : alts,
        answerId: widget.answerId,
        isAnswer: widget.isAnswer,
      )),
      Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03),
          child: Text(
              widget.answerId == null
                  ? ''
                  : alts[widget.answerId!].isCorrect
                      ? 'Korrekt!'
                      : 'Feil!',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: widget.answerId == null
                      ? Colors.red
                      : alts[widget.answerId!].isCorrect
                          ? Colors.teal
                          : Colors.red))),
      Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 50),
          child: Text(
            widget.isAnswer ? widget.questions[index].clarification : '',
            style: TextStyle(color: Colors.teal),
            textAlign: TextAlign.center,
          )),
      widget.isAnswer
          ? ElevatedButton(
              onPressed: () => {
                    setState(() => {
                          index + 1 < widget.questions.length
                              ? index += 1
                              : Navigator.of(context).pop(),
                        }),
                    BlocProvider.of<CourseDetailBloc>(context).add(
                        CourseDetailRequested(
                            course: widget.course,
                            isAnswer: false,
                            isQuiz: true))
                  },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  index + 1 < widget.questions.length
                      ? 'Neste Spørsmål'
                      : 'Fullfør quiz',
                  style: TextStyle(fontSize: 16),
                ),
              ))
          : Container(),
    ]);
  }
}
