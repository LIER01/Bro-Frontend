import 'dart:developer';

import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseRepository repository;

  CourseDetailBloc({@required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<CourseDetailState> mapEventToState(CourseDetailEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is CourseDetailRequested) {
      try {
        if (currentState is Loading) {
          final result = await repository.getCourse(event.course_id);

          final course_data = result.data['course'];

          final return_course = Course(
            title: course_data['title'],
            description: course_data['description'],
            questions: course_data['questions'],
            slides: course_data['slides'],
          );

          yield CourseState(course: return_course);
          return;
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    } else if (event is QuizRequested) {
      try {
        if (currentState is CourseState) {
          yield QuizState();
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
