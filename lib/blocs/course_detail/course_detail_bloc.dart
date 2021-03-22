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
    if (event is CourseDetailRequested) {
      try {
        if (!event.is_quiz) {
          final result = await repository.getCourse(event.course_id);
          final course_data = result.data['course'];

          final return_course = Course(
            title: course_data['title'],
            description: course_data['description'],
            questions: course_data['questions'],
            slides: course_data['slides'],
          );
          yield CourseState(
              course: return_course,
              is_answer: event.is_answer,
              is_quiz: event.is_quiz,
              answer_id: event.answer_id);
          return;
        } else {
          yield CourseState(
              is_quiz: event.is_quiz,
              is_answer: event.is_answer,
              answer_id: event.answer_id);
          return;
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    } else if (event is QuizRequested) {
      try {
        if (event.is_answer = true) {
          yield QuizState(
              is_answer: event.is_answer, answer_id: event.answer_id);
          return;
        } else if (event.is_answer = false) {
          yield QuizState(
              is_answer: event.is_answer, answer_id: event.answer_id);
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
