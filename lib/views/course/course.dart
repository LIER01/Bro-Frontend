import 'package:bro/views/course/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'course_card_view.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quiz.dart';
import 'package:bro/views/course/exit_verification.dart';

class CourseDetailView extends StatefulWidget {
  final int courseId;
  CourseDetailView({required this.courseId, Key? key}) : super(key: key);

  @override
  _CourseDetailViewState createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  late Course data;
  late CourseDetailBloc _courseDetailBloc;

  @override
  void initState() {
    super.initState();
    _courseDetailBloc = BlocProvider.of<CourseDetailBloc>(context);
    _courseDetailBloc.add(CourseDetailRequested(
      courseId: widget.courseId,
      isQuiz: false,
      isAnswer: false,
      answerId: null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailBloc, CourseDetailState>(
      builder: (context, state) {
        //log(state.toString());
        if (state is Loading) {
          return Scaffold(
            appBar: AppBar(title: Text('Loading')),
            body: LinearProgressIndicator(),
          );
        }

        if (state is Failed) {
          return _failureState(context, state.err);
        }

        if (state is CourseState) {
          data = state.course;
          if (state.isQuiz == false) {
            return Scaffold(
              appBar: AppBar(
                  title: Text(data.title),
                  //Exitverification will not trigger when using phone built in back button ot navbar
                  leading: ExitVerification(context, data)),
              body: _course_view_builder(context, data),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                  title: Text(data.title),
                  leading: ExitVerification(context, data)),
              body: Center(
                  child: QuizView(
                      course: data,
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
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: CardContainerView(
        course: data,
      ));
}

Widget _failureState(context, errtext) {
  return Scaffold(
    appBar: AppBar(title: Text('     ')),
    body: Center(child: Text(errtext)),
  );
}
