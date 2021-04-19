import 'dart:ui';

import 'package:bro/blocs/course_detail/course_detail_bloc.dart';
import 'package:bro/blocs/course_detail/course_detail_event.dart';
import 'package:bro/models/new_course.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alternative extends StatefulWidget {
  final String name;
  final bool isTrue;
  final int id;
  final bool isPressed;
  final Courses course;
  final Media? image;

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
              maxWidth: widget.isPressed
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width / 2.5,
              maxHeight: widget.isPressed
                  ? MediaQuery.of(context).size.width / 2.1
                  : MediaQuery.of(context).size.width / 2.5),
          alignment: FractionalOffset.center,
          decoration: widget.isPressed
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: validColor))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 2,
                      color: widget.isPressed
                          ? validColor
                          : Colors.teal.shade200)),
          child: Stack(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                ),
                child: widget.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(3.5),
                        child: Center(
                            child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 12,
                              child: CachedNetworkImage(
                                imageUrl: widget.image!.url,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    FractionallySizedBox(
                                  heightFactor: 0.3,
                                  widthFactor: 0.3,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 2,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: widget.isPressed
                                        ? validColor
                                        : Colors.teal),
                                child: Center(
                                    child: Text(widget.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: widget.isPressed
                                                ? Colors.white
                                                : Colors.white))),
                              ),
                            )
                          ],
                        )),
                      )
                    : Center(
                        child: Text(widget.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: widget.isPressed
                                    ? validColor
                                    : Colors.teal))),
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
