import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/data/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data/course_mock.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('CourseListBloc', () {
    late HomeRepository homeRepository;
    late HomeBloc homeBloc;

    setUp(() {
      homeRepository = MockHomeRepository();
      when(() => homeRepository.getRecommendedCourses('NO', 0, 10)).thenAnswer(
          (_) =>
              Future.value(QueryResult(source: null, data: mockedCourseMap)));
      homeBloc = HomeBloc(repository: homeRepository);
    });

    blocTest(
      'should emit Failed if repository throws',
      build: () {
        when(() => homeRepository.getRecommendedCourses('NO', 0, 10))
            .thenThrow(Exception('Woops'));
        when(() => homeRepository.getHome()).thenThrow(Exception('Woops'));
        return homeBloc;
      },
      act: (HomeBloc bloc) async => bloc.add(HomeRequested()),
      expect: () => <HomeState>[Failed()],
    );

    blocTest(
      'initial state is correct',
      build: () => homeBloc,
      expect: () => <HomeState>[],
    );
  });
}
