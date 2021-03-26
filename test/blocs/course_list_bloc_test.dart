import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';

import '../mock_data/course_mock.dart';

class MockCourseRepository extends Mock implements CourseRepository {}

void main() {
  group('CourseListBloc', () {
    CourseRepository courseRepository;
    CourseListBloc courseListBloc;

    setUp(() {
      courseRepository = MockCourseRepository();
      when(courseRepository.getCourses(0, 10)).thenAnswer(
          (_) => Future.value(QueryResult(source: null, data: mockedResult)));
      courseListBloc = CourseListBloc(repository: courseRepository);
    });

    blocTest(
      'should emit Failed if repository throws',
      build: () {
        when(courseRepository.getCourses(0, 10)).thenThrow(Exception('Woops'));
        return courseListBloc;
      },
      act: (CourseListBloc bloc) async => bloc.add(CourseListRequested()),
      expect: () => <CourseListState>[Failed()],
    );

    blocTest(
      'initial state is correct',
      build: () => courseListBloc,
      expect: () => <CourseListState>[],
    );

    blocTest(
      'should load more items in response to an CourseListRequested event',
      build: () => courseListBloc,
      act: (CourseListBloc bloc) async => bloc.add(CourseListRequested()),
      expect: () => [
        isA<Success>(),
      ],
    );
  });
}
