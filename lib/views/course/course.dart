import 'package:bro/views/course/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'info_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'dart:developer';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:bro/views/course/course_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bro/views/course/alternative_container.dart';
import 'quiz.dart';

class CourseDetailView extends StatefulWidget {
  CourseDetailView({Key key}) : super(key: key);

  @override
  _CourseDetailViewState createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  Course data;
  CourseDetailBloc _courseDetailBloc;

  @override
  void initState() {
    super.initState();
    _courseDetailBloc = BlocProvider.of<CourseDetailBloc>(context);
    _courseDetailBloc.add(CourseDetailRequested(
      courseId: 1,
      isQuiz: false,
      isAnswer: false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailBloc, CourseDetailState>(
      // ignore: missing_return
      builder: (context, state) {
        //log(state.toString());
        if (state is Loading) {
          return Scaffold(
            appBar: AppBar(title: Text('Loading')),
            body: CircularProgressIndicator(),
          );
        }

        if (state is Failed) {
          return Scaffold(
            appBar: AppBar(title: Text('     ')),
            body: Center(child: Text('Det har skjedd en feil')),
          );
        }

        if (state is CourseState) {
          data = state.course;
          if (!state.isQuiz) {
            return Scaffold(
              appBar: AppBar(title: Text(data.title)),
              body: _course_view_builder(context, data),
            );
          } else {
            return Scaffold(
              appBar: AppBar(title: Text(data.title)),
              body: Center(
                  child: QuizView(
                      questions: data.questions,
                      isAnswer: state.isAnswer,
                      title: data.title,
                      answerId: state.answerId)),
            );
          }
        }
        return Container();
      },
    );
  }
}

Widget _course_view_builder(context, data) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      child: CardContainerView(
        list: data.slides,
        course: data,
      ));
}

class CardContainerView extends StatefulWidget {
  CardContainerView({
    Key key,
    this.list,
    this.res,
    this.course,
  }) : super(key: key);
  final List list;
  final QueryResult res;
  final Course course;
  @override
  _CardContainerViewState createState() => _CardContainerViewState();
}

class _CardContainerViewState extends State<CardContainerView> {
  ScrollController _controller;
  double indx = 0;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (indx != (_controller.offset / context.size.width).round()) {
        setState(() {
          indx = (_controller.offset / context.size.width).roundToDouble();
        });
      }
      print(indx);
      //SET LIMITER PÅ ANTALL UTREGNINGER?
    });
    super.initState();
  }

//ScrollController functions for swiping right and left
  void _moveRight() {
    _controller
        .animateTo(_controller.offset + context.size.width,
            curve: Curves.linear, duration: Duration(milliseconds: 200))
        .whenComplete(() => setState(() {
              indx = _controller.offset / context.size.width;
            }));
  }

  void _moveLeft() {
    _controller
        .animateTo(_controller.offset - context.size.width,
            curve: Curves.linear, duration: Duration(milliseconds: 200))
        .whenComplete(() => setState(() {
              indx = _controller.offset / context.size.width;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (context == null) {
      return Scaffold(body: Text('Context is null, yo'));
    }

    if (widget.list.isNotEmpty) {
      return Column(children: [
        FloatingActionButton(
          child: Text('test'),
          onPressed: () {
            BlocProvider.of<CourseDetailBloc>(context).add(
                CourseDetailRequested(
                    course: widget.course, isQuiz: true, isAnswer: false));
          },
        ),
        Container(
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
                      title: widget.list[index]['title'],
                      description: widget.list[index]['description'],
                      image: widget.list[index]['image']);
                })),
        //Shows which page the user is on
        DotsIndicator(
            dotsCount: widget.list.length,
            position: indx.roundToDouble(),
            decorator: DotsDecorator(
                color: Colors.grey[350], activeColor: Colors.teal)),
        //Scroll buttons
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
              onTap: () => {_moveLeft()},
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_circle_down,
                        color: Colors.teal,
                        size: 72,
                      )))),
          GestureDetector(
              onTap: () => {_moveRight()},
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_circle_down,
                        color: Colors.teal,
                        size: 72,
                      )))),
        ])
      ]);
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }
}
