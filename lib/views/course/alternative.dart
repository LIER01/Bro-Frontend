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
  final Object? image;

  Alternative(
      this.course, this.id, this.name, this.isTrue, this.image, this.isPressed);

  @override
  _AlternativeState createState() => _AlternativeState();
}

class _AlternativeState extends State<Alternative> {
  late Color validColor;
  @override
  Widget build(BuildContext context) {
    validColor = widget.isTrue ? Colors.teal : Colors.red;
    return GestureDetector(
        onTap: () {
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
                  border: Border.all(color: validColor))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: widget.isPressed ? validColor : Colors.grey)),
          child: Stack(
            children: [
              Center(
                child: Text(widget.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.isPressed ? validColor : Colors.teal)),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    widget.isPressed ? Icons.check_box : Icons.clear,
                    color: validColor,
                    size: widget.isPressed ? 35 : 0,
                  ))
            ],
          ),
        ));
  }
}
