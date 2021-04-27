import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data/Non_Lang_courses_list_mock.dart';
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

      when(() => courseRepository.getLangCourses('NO', 0, 10)).thenAnswer(
          (_) => Future.value(QueryResult(source: null, data: mockedResult)));
      courseListBloc = CourseListBloc(
          repository: courseRepository,
          preferredLanguageBloc: preferredLanguageBloc);
    });

    blocTest(
      'should emit Failed if repository throws',
      build: () {
        when(() => courseRepository.getNonLangCourses(0, 10))
            .thenThrow(Exception('Woops'));
        return courseListBloc;
      },
      act: (CourseListBloc bloc) async =>
          bloc.add(CourseListRefresh(preferredLang: 'NO')),
      expect: () => <CourseListState>[Failed()],
    );

    blocTest(
      'initial state is correct',
      build: () => courseListBloc,
      expect: () => <CourseListState>[],
    );

    blocTest(
      'should load initial items on a CourseListRefresh',
      build: () {
        when(() => courseRepository.getNonLangCourses(any(), 10)).thenAnswer(
            (_) => Future.value(QueryResult(
                source: null, data: non_lang_courses_mock['data'])));
        when(() => courseRepository.getLangCourses(any(), any(), any()))
            .thenAnswer((_) => Future.value(QueryResult(
                source: null, data: non_lang_courses_mock['data'])));
        return courseListBloc;
      },
      act: (CourseListBloc bloc) async =>
          bloc.add(CourseListRefresh(preferredLang: 'NO')),
      expect: () => [
        isA<Success>(),
      ],
    );

    blocTest(
      'should load more items in response to an CourseListRequested event',
      build: () {
        when(() => courseRepository.getNonLangCourses(any(), 10)).thenAnswer(
            (_) => Future.value(QueryResult(
                source: null, data: non_lang_courses_mock['data'])));
        when(() => courseRepository.getLangCourses(any(), any(), 10))
            .thenAnswer((_) => Future.value(QueryResult(
                source: null, data: non_lang_courses_mock['data'])));
        when(() => preferredLanguageRepository.getPreferredLangSlug())
            .thenAnswer((_) => Future.value('NO'));
        return courseListBloc;
      },
      act: (CourseListBloc bloc) async {
        bloc.add(CourseListRefresh(preferredLang: 'NO'));
        bloc.add(CourseListRequested());
      },
      expect: () => [
        isA<Success>(),
        isA<Success>(),
      ],
    );
  });
}
