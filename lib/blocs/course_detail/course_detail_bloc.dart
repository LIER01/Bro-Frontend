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

  CourseDetailBloc({@required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<CourseDetailState> mapEventToState(CourseDetailEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    if (event is CourseDetailRequested) {
      if (event.isQuiz == null ||
          (event.course == null || event.courseId == null) ||
          (event.isAnswer == true && event.answerId == null)) {
        yield Failed(err: 'Error, bad request');
        return;
      }
      yield Loading();
      try {
        if (!event.isQuiz) {
          // ignore: omit_local_variable_types
          QueryResult result = await repository.getCourse(event.courseId);

          // ignore: omit_local_variable_types
          int attempt = 1;
          // If the result has an exception, we attempt to connect two more times before yielding a failure
          while (result.hasException) {
            if (attempt == 3) {
              yield Failed(err: 'Failed to connect to server');
              return;
            }
            result = await repository.getCourse(event.courseId);
            attempt += 1;
          }

          final course_data = result.data['course'];

          final returnCourse = Course(
            title: course_data['title'],
            description: course_data['description'],
            questions: course_data['questions'],
            slides: course_data['slides'],
          );

          yield CourseState(
              course: returnCourse,
              isAnswer: event.isAnswer,
              isQuiz: event.isQuiz,
              answerId: event.answerId);

          return;
        } else if (event.isQuiz) {
          yield CourseState(
              course: event.course,
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
      }
    }
    yield Failed(err: 'Error, bad request');
  }
}
