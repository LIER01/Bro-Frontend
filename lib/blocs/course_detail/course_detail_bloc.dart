import 'dart:developer';

import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      try {
        if (!event.isQuiz) {
          final result = await repository.getCourse(event.courseId);
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
        } else {
          yield CourseState(
              course: event.course,
              isQuiz: event.isQuiz,
              isAnswer: event.isAnswer,
              answerId: event.answerId);
          return;
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    }
  }
}
