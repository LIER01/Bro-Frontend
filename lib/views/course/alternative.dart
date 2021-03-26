import 'dart:collection';

import 'package:bro/blocs/course_detail/course_detail_bloc.dart';
import 'package:bro/blocs/course_detail/course_detail_event.dart';
import 'package:bro/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alternative extends StatefulWidget {
  final String name;
  final bool isTrue;
  final int id;
  final bool isPressed;
  final Course course;
  // This lets us trigger the border color change if it is pressed.
  final LinkedHashMap<String, dynamic> image;

  Alternative(
      this.course, this.id, this.name, this.isTrue, this.image, this.isPressed);

  @override
  _AlternativeState createState() => _AlternativeState();
}

class _AlternativeState extends State<Alternative> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          debugPrint('triggerd');
          BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailRequested(
              course: widget.course,
              isAnswer: true,
              answerId: widget.id,
              isQuiz: true));
        },
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2.5,
              maxHeight: MediaQuery.of(context).size.width / 2.5),
          alignment: FractionalOffset.center,
          decoration: widget.isPressed
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: widget.isTrue ? Colors.green : Colors.red))
              : BoxDecoration(border: Border.all(color: Colors.black)),
          child: Stack(
            children: [
              Center(
                child: Text(widget.name),
              ),
            ],
          ),
        ));
  }
}
