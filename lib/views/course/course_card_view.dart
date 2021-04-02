import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'info_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardContainerView extends StatefulWidget {
  CardContainerView({
    Key? key,
    required this.list,
    required this.course,
  }) : super(key: key);
  final List list;
  final Course course;
  @override
  _CardContainerViewState createState() => _CardContainerViewState();
}

class _CardContainerViewState extends State<CardContainerView> {
  late ScrollController _controller;
  double indx = 0;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (indx != (_controller.offset / context.size!.width).round()) {
        setState(() {
          indx = (_controller.offset / context.size!.width).roundToDouble();
        });
      }
    });
    super.initState();
  }

//ScrollController functions for swiping right and left
  void _moveRight() {
    _controller
        .animateTo(_controller.offset + context.size!.width,
            curve: Curves.linear, duration: Duration(milliseconds: 200))
        .whenComplete(() => setState(() {
              indx = _controller.offset / context.size!.width;
            }));
  }

  void _moveLeft() {
    _controller
        .animateTo(_controller.offset - context.size!.width,
            curve: Curves.linear, duration: Duration(milliseconds: 200))
        .whenComplete(() => setState(() {
              indx = _controller.offset / context.size!.width;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (context == null) {
      return Scaffold(body: Text('Context is null, yo'));
    }

    if (widget.list.isNotEmpty) {
      return Column(
        children: [
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    physics: PageScrollPhysics(),
                    itemCount: widget.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InfoCard(
                          title: widget.list[index].title,
                          description: widget.list[index].description,
                          image: widget.list[index].image);
                    })),
          ),
          //Shows which page the user is on
          DotsIndicator(
              dotsCount: widget.list.length,
              position: indx.roundToDouble(),
              decorator: DotsDecorator(
                  color: Colors.grey[350]!, activeColor: Colors.teal)),
          //Scroll buttons
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(children: <Widget>[
                GestureDetector(
                    onTap: () => {_moveLeft()},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.073),
                          child: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.arrow_circle_down,
                                color: Colors.teal,
                                size: MediaQuery.of(context).size.width * 0.175,
                              ))),
                    )),
                indx + 1 != widget.list.length
                    ? GestureDetector(
                        onTap: () => {_moveRight()},
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 30),
                              child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_circle_down,
                                    color: Colors.teal,
                                    size: MediaQuery.of(context).size.width *
                                        0.175,
                                  ))),
                        ))
                    : Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * 0.015,
                              horizontal: 30),
                          child: ElevatedButton(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                                child: Text('Start Quiz',
                                    style: TextStyle(fontSize: 16))),
                            onPressed: () {
                              BlocProvider.of<CourseDetailBloc>(context).add(
                                  CourseDetailRequested(
                                      course: widget.course,
                                      isQuiz: true,
                                      isAnswer: false));
                            },
                          ),
                        ),
                      )
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Trykk på bildet for å lese mer',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 18),
            ),
          )
        ],
      );
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }
}
