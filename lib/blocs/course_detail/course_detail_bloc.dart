import 'dart:developer';

import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/new_course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseRepository repository;

  CourseDetailBloc({required this.repository}) : super(Loading());

  @override
  Stream<CourseDetailState> mapEventToState(CourseDetailEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    if (event is CourseDetailRequested) {
      yield Loading();
      if ((event.course == null && event.courseGroupSlug == null) ||
          (event.isAnswer == true && event.answerId == null)) {
        yield Failed(err: 'Error, bad request');
        return;
      }
      try {
        if (event.isQuiz == false) {
          if (event.course == null && event.courseGroupSlug != null) {
            yield await _retrieveCourse(event, 'NO');
            return;
          } else if ((event.course != null)) {
            yield CourseState(
                course: event.course!,
                isQuiz: event.isQuiz,
                isAnswer: event.isAnswer,
                answerId: event.answerId);
            return;
          } else {
            // If the value of quiz is not defined, we yield a failure. This is due to the fact that "isQuiz"
            // is a required parameter in the "CourseDetailRequested" event, and thus any event without that defined
            // must be malicious.
            yield Failed(err: 'Error, bad request');
            return;
          }
        } else if (event.isQuiz == true) {
          if (event.course == null && event.courseGroupSlug != null) {
            yield await _retrieveCourse(event, 'NO');
            return;
          } else if (event.course == null && event.courseGroupSlug != null) {}
          yield CourseState(
              course: event.course!,
              isQuiz: event.isQuiz,
              isAnswer: event.isAnswer,
              answerId: event.answerId);
          return;
        } else {
          // If the value of quiz is not defined, we yield a failure. This is due to the fact that "isQuiz"
          // is a required parameter in the "CourseDetailRequested" event, and thus any event without that defined
          // must be malicious.
          yield Failed(err: 'Error, bad request');
          return;
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed(err: 'Error, bad request');
        return;
      }
    }
    yield Failed(err: 'Error, bad request');
    return;
  }

  Future<CourseDetailState> _retrieveCourse(
      CourseDetailRequested event, String pref_lang_slug) async {
    try {
      return await repository
          .getNewCourseQuery(event.courseGroupSlug!, pref_lang_slug)
          .then((res) async {
        if (res.data!.isEmpty) {
          final fallbackCourseResult =
              await repository.getNewCourseQuery(event.courseGroupSlug!, 'NO');
          final fallbackCourse =
              Courses.fromJson(fallbackCourseResult.data!['courses'][0]);
          return CourseState(
              course: fallbackCourse,
              isQuiz: event.isQuiz,
              isAnswer: event.isAnswer,
              answerId: event.answerId);
        } else if (res.data!.isNotEmpty) {
          try {
            final returnCourse = Courses.fromJson(res.data!['courses'][0]);

            return CourseState(
                course: returnCourse,
                isQuiz: event.isQuiz,
                isAnswer: event.isAnswer,
                answerId: event.answerId);
          } catch (e, stackTrace) {
            log(e.toString());
            log(stackTrace.toString());
            return Failed(err: 'Error, bad request 2222');
          }
        } else {
          return Failed(err: 'Error, bad request');
        }
      });
    } on NetworkException catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return Failed(err: 'Error, failed to contact server');
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());

      return Failed(err: 'Error, bad request');
    }
  }
}
