import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data/Non_Lang_courses_list_mock.dart';

class MockCourseRepository extends Mock implements CourseRepository {}

void main() {
  group('CourseListBloc', () {
    late CourseRepository courseRepository;
    late CourseListBloc courseListBloc;

    setUp(() {
      courseRepository = MockCourseRepository();
      courseListBloc = CourseListBloc(repository: courseRepository);
    });

    blocTest(
      'should emit Failed if repository throws',
      build: () {
        when(() => courseRepository.getNonLangCourses(0, 10))
            .thenThrow(Exception('Woops'));
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
      build: () {
        when(() => courseRepository.getNonLangCourses(any(), 10)).thenAnswer(
            (_) => Future.value(QueryResult(
                source: null, data: non_lang_courses_mock['data'])));
        return courseListBloc;
      },
      act: (CourseListBloc bloc) async =>
          bloc.add(CourseListRequested(preferredLanguageSlug: 'NO')),
      expect: () => [
        isA<Success>(),
      ],
    );
  });
}
