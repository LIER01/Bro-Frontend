import 'package:auto_direction/auto_direction.dart';
import 'package:bro/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'info_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardContainerView extends StatefulWidget {
  CardContainerView({
    Key? key,
    required this.course,
  }) : super(key: key);
  final Course course;
  @override
  _CardContainerViewState createState() => _CardContainerViewState();
}

class _CardContainerViewState extends State<CardContainerView> {
  late final List<Slide> list;

  late ScrollController _controller;
  double indx = 0;
  @override
  void initState() {
    list = widget.course.slides;
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
    if (list.isNotEmpty) {
      return Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AutoDirection(
                      text: list[index].description,
                      child: InfoCard(
                          title: list[index].title,
                          description: list[index].description,
                          image: list[index].media),
                    );
                  })),
          //Shows which page the user is on
          DotsIndicator(
              dotsCount: list.length,
              position: indx.roundToDouble(),
              decorator: DotsDecorator(
                  color: Colors.grey[350]!, activeColor: Colors.teal)),
          //Scroll buttons
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.075,
              child: Stack(children: <Widget>[
                GestureDetector(
                    onTap: () => {_moveLeft()},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.073),
                          child: FaIcon(
                            FontAwesomeIcons.chevronCircleLeft,
                            color: indx != 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.3),
                            size: MediaQuery.of(context).size.width * 0.15,
                          )),
                    )),
                indx + 1 != list.length
                    ? GestureDetector(
                        onTap: () => {_moveRight()},
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 30),
                              child: FaIcon(
                                FontAwesomeIcons.chevronCircleRight,
                                color: Colors.teal,
                                size: MediaQuery.of(context).size.width * 0.15,
                              )),
                        ))
                    : Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30,
                              MediaQuery.of(context).size.width * 0.015, 30, 0),
                          child: ElevatedButton(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                child: Text('START QUIZ',
                                    style: Theme.of(context).textTheme.button)),
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
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
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
