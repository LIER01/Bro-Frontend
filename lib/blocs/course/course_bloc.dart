import 'dart:collection';
import 'dart:developer';

import 'package:bro/blocs/course/course_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CourseBloc extends Bloc<CourseEvents, CourseStates> {
  CourseRepository repository;

  CourseBloc({@required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<CourseStates> mapEventToState(CourseEvents event) async* {
    if (event is CoursesRequested) {
      try {
        final result = await repository.getCourses();

        final List<dynamic> courses = result.data['courses'] as List<dynamic>;

        final List<Course> listOfCourses = courses
            .map((dynamic e) => Course(
                  title: e['title'],
                  description: e['description'],
                  questions: e['questions'],
                  slides: e['slides'],
                ))
            .toList();

        yield Success(courses: listOfCourses);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    } else if (event is CourseRequested) {
      yield (Loading());
      try {
        final result = await repository.getCourse(event.course_id);
        final c_d = result.data["course"];

        final course = Course(
          title: c_d["title"],
          description: c_d["description"],
          questions: c_d["questions"],
          slides: c_d["slides"],
        );

        yield Course_Success(course: course);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    } else if (event is QuizSwitchRequested) {
      yield Switch_to_Quiz();
    }
  }
}

/*
  Stream<CourseStates> _mapFetchCourseDataToStates(
      CourseRequested event) async* {
    final query = event.query;
    final variables = event.variables ?? null;

    try {
      final result = await repository.getCourses();

      if (result.hasException) {
        print("graphQLErrors: ${result.exception.graphqlErrors.toString()}");

        yield Failed(result.exception.graphqlErrors[0]);
      } else {
        yield Success(result.data);
      }
    } catch (e) {
      print(e);
      yield Failed(e.toString());
    }
  }
}
*/
