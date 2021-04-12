import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../mock_data/course_detail_mock.dart';
import 'package:bro/data/course_repository.dart';
import 'test_helpers.dart';

import '../../mock_data/new_course_mock.dart';

class MockCourseRepository extends Mock implements CourseRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(Failed(err: 'This is an error'));
  });

  mainBloc();
}

void mainBloc() {
  group('CourseDetailBloc', () {
    late CourseRepository courseRepository;
    late CourseDetailBloc courseDetailBloc;

    setUp(() {
      courseRepository = MockCourseRepository();
      when(() => courseRepository.getCourse(any())).thenAnswer((_) =>
          Future.value(QueryResult(source: null, data: course_detail_mock)));
      courseDetailBloc = CourseDetailBloc(repository: courseRepository);
    });

    tearDown(() {
      courseDetailBloc.close();
    });

    blocTest(
      'should emit failed if a WrongEvent is added',
      build: () => courseDetailBloc,
      act: (CourseDetailBloc courseDetailBloc) async => courseDetailBloc.add(
          WrongEvent(
              course: referenceCourse,
              courseId: 1,
              isQuiz: false,
              isAnswer: true,
              answerId: 1)),
      expect: () => [
        isInstanceOf<Failed>(),
      ],
    );

    blocTest(
      'should emit failed if server does not respond',
      build: () {
        when(() => courseRepository.getCourse(any())).thenThrow(
            NetworkException(message: 'Error,connection failed', uri: Uri()));
        return courseDetailBloc;
      },
      act: (CourseDetailBloc courseDetailBloc) async => courseDetailBloc.add(
          CourseDetailRequested(
              courseGroupSlug: 'k1',
              isQuiz: false,
              isAnswer: false,
              answerId: 1)),
      expect: () => [
        Loading(),
        isInstanceOf<Failed>(),
      ],
    );

    blocTest(
      'should emit CourseState when correct values are inserted',
      build: () => courseDetailBloc,
      act: (CourseDetailBloc courseDetailBloc) async => courseDetailBloc.add(
          CourseDetailRequested(
              course: referenceCourses,
              courseGroupSlug: 'k1',
              isQuiz: false,
              isAnswer: false,
              answerId: 1)),
      expect: () => [
        Loading(),
        isA<CourseState>(),
      ],
    );

    blocTest(
      'should emit Quiz when correct values are inserted',
      build: () {
        return courseDetailBloc;
      },
      act: (CourseDetailBloc courseDetailBloc) async => courseDetailBloc.add(
          CourseDetailRequested(
              course: referenceCourses,
              courseGroupSlug: 'k1',
              isQuiz: true,
              isAnswer: false,
              answerId: 1)),
      expect: () => [
        Loading(),
        isA<CourseState>(),
      ],
    );
  });
}
