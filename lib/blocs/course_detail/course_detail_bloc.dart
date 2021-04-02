import 'dart:developer';

import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseRepository repository;

  CourseDetailBloc({required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<CourseDetailState> mapEventToState(CourseDetailEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    if (event is CourseDetailRequested) {
      yield Loading();
      if (event.isQuiz == null ||
          (event.course == null && event.courseId == null) ||
          (event.isAnswer == true && event.answerId == null)) {
        yield Failed(err: 'Error, bad request');
        return;
      }
      try {
        if (event.isQuiz == false) {
          yield await _retrieveCourse(event);
          return;
        } else if (event.isQuiz == true) {
          if (event.course == null && event.courseId != null) {
            yield await _retrieveCourse(event);
            return;
          } else if (event.course == null && event.courseId != null) {}
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

  Future<CourseDetailState> _retrieveCourse(CourseDetailRequested event) async {
    try {
      final result = await repository.getCourse(event.courseId!).then((res) {
        debugPrint(res.data.toString());
        debugPrint(event.courseId.toString());
        final returnCourse = Course.fromJson(res.data!['course']);
        return CourseState(
            course: returnCourse,
            isQuiz: event.isQuiz,
            isAnswer: event.isAnswer,
            answerId: event.answerId);
      });
      return result;
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
