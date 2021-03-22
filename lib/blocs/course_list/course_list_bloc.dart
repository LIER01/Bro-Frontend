import 'dart:developer';

import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseRepository repository;

  CourseListBloc({@required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<CourseListState> mapEventToState(CourseListEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is CourseListRequested && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Loading) {
          final result = await repository.getCourses(0, 10);

          final courses = result.data['courses'] as List<dynamic>;

          final listOfCourses = courses
              .map((dynamic e) => Course(
                    title: e['title'],
                    description: e['description'],
                    questions: e['questions'],
                    slides: e['slides'],
                  ))
              .toList();

          yield Success(courses: listOfCourses, hasReachedMax: false);
          return;
        }

        if (currentState is Success) {
          final result =
              await repository.getCourses(currentState.courses.length, 10);
          final courses = result.data['courses'];
          yield courses.length == 0
              ? currentState.copyWith(hasReachedMax: true)
              : Success(
                  courses: currentState.courses + courses,
                  hasReachedMax: false,
                );
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    }
  }
}

bool _hasReachedMax(CourseListState state) =>
    state is Success && state.hasReachedMax;
