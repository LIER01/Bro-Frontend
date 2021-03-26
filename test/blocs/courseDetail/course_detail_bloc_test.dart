import 'dart:io';

import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/category_repository.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';
import '../../mock_data/course_detail_mock.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bro/data/course_repository.dart';
import '../../mock_data/course_detail_mock.dart';
import 'package:meta/meta.dart';
import 'test_helpers.dart';

class MockCourseRepository extends Mock implements CourseRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(Failed(err: 'This is an error'));
  });

  mainBloc();
}

void mainBloc() {
  group('CourseDetailBloc', () {
    CourseRepository courseRepository;
    CourseDetailBloc courseDetailBloc;

    setUp(() {
      courseRepository = MockCourseRepository();
      when(() => courseRepository.getCourse(1)).thenAnswer((_) =>
          Future.value(QueryResult(source: null, data: course_detail_mock)));
      courseDetailBloc = CourseDetailBloc(repository: courseRepository);
    });

    blocTest(
      'should emit failed if a WrongEvent is added',
      build: () => courseDetailBloc,
      act: (CourseDetailBloc bloc) async => bloc.add(WrongEvent(
          course: Course(),
          courseId: 1,
          isQuiz: false,
          isAnswer: true,
          answerId: 1)),
      expect: () => [
        Loading(),
        isInstanceOf<Failed>(),
      ],
    );

    blocTest(
      'should emit failed if server does not respond',
      build: () {
        when(() => courseRepository.getCourse(1)).thenThrow(
            NetworkException(message: 'Error,connection failed', uri: Uri()));
        return courseDetailBloc;
      },
      act: (CourseDetailBloc bloc) async => bloc.add(CourseDetailRequested(
          course: Course(),
          courseId: 1,
          isQuiz: false,
          isAnswer: false,
          answerId: 1)),
      expect: () => [
        Loading(),
        Failed(err: 'Error, failed to contact server'),
      ],
    );
  });
}
