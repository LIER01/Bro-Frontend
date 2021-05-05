import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data/course_list_mock.dart';
import '../../mock_data/category_mock.dart';

class MockCourseRepository extends Mock implements CourseRepository {}

class MockPreferredLanguageRepository extends Mock
    implements PreferredLanguageRepository {}

void main() {
  group('CourseListBloc', () {
    late CourseRepository courseRepository;
    late CourseListBloc courseListBloc;
    late PreferredLanguageBloc preferredLanguageBloc;
    late PreferredLanguageRepository preferredLanguageRepository;
    setUp(() {
      courseRepository = MockCourseRepository();
      preferredLanguageRepository = MockPreferredLanguageRepository();
      preferredLanguageBloc =
          PreferredLanguageBloc(repository: preferredLanguageRepository);

      when(() => courseRepository.getCourses('NO', 0, 10, false)).thenAnswer(
          (_) => Future.value(QueryResult(source: null, data: mockedResult)));
      courseListBloc = CourseListBloc(
          repository: courseRepository,
          preferredLanguageBloc: preferredLanguageBloc);
    });

    blocTest(
      'should emit Failed if repository throws',
      build: () {
        when(() => courseRepository.getCourses(any(), any(), any(), any()))
            .thenThrow(Exception('Woops'));
        return courseListBloc;
      },
      act: (CourseListBloc bloc) async => bloc.add(CourseListRefresh()),
      expect: () => <CourseListState>[CourseListFailed()],
    );

    blocTest(
      'initial state is correct',
      build: () => courseListBloc,
      expect: () => <CourseListState>[],
    );

    blocTest(
      'should load initial items on a CourseListRefresh',
      build: () {
        when(() => courseRepository.getCourses(any(), any(), any(), false))
            .thenAnswer((_) =>
                Future.value(QueryResult(source: null, data: mockCourseMap)));
        when(() => preferredLanguageRepository.getPreferredLangSlug())
            .thenAnswer((_) => Future.value('NO'));
        return courseListBloc;
      },
      act: (CourseListBloc bloc) async => bloc.add(CourseListRefresh()),
      expect: () => [
        isA<CourseListSuccess>(),
      ],
    );

    blocTest(
      'should load more items in response to an CourseListRequested event',
      build: () {
        when(() => courseRepository.getCourses(any(), any(), 10, false))
            .thenAnswer((_) =>
                Future.value(QueryResult(source: null, data: mockCourseMap)));
        when(() => preferredLanguageRepository.getPreferredLangSlug())
            .thenAnswer((_) => Future.value('NO'));
        return courseListBloc;
      },
      act: (CourseListBloc bloc) async {
        bloc.add(CourseListRefresh());
        bloc.add(CourseListRequested());
      },
      expect: () => [
        isA<CourseListSuccess>(),
        isA<CourseListSuccess>(),
      ],
    );
  });
}
