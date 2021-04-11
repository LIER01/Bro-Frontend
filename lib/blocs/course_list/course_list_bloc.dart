import 'dart:developer';

import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/reduced_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseRepository repository;

  CourseListBloc({required this.repository}) : super(Loading());

  @override
  Stream<CourseListState> mapEventToState(CourseListEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is CourseListRequested && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Loading) {
          final result = await repository.getCourses(0, 10);

          final courses = result.data!['courses'] as List<dynamic>;
          debugPrint(courses.toString());
          final listOfCourses =
              courses.map((dynamic e) => ReducedCourse.fromJson(e)).toList();

          yield Success(courses: listOfCourses, hasReachedMax: false);
          return;
        }

        if (currentState is Success) {
          final result =
              await repository.getCourses(currentState.courses.length, 10);
          final courses = result.data!['courses'];
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
