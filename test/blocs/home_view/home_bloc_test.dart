import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockPreferredLanguageRepository extends Mock
    implements PreferredLanguageRepository {}

void main() {
  group('CourseListBloc', () {
    late HomeRepository homeRepository;
    late HomeBloc homeBloc;
    PreferredLanguageBloc(repository: MockPreferredLanguageRepository());
    setUp(() {
      homeRepository = MockHomeRepository();
      homeBloc = HomeBloc(
        homeRepository: homeRepository,
      );
    });

    blocTest(
      'should emit Failed if repository throws',
      build: () {
        when(() => homeRepository.getHome()).thenThrow(Exception('Woops'));
        return homeBloc;
      },
      act: (HomeBloc bloc) async => bloc.add(HomeRequested()),
      expect: () => <HomeState>[HomeFailed()],
    );

    blocTest(
      'initial state is correct',
      build: () => homeBloc,
      expect: () => <HomeState>[],
    );
  });
}
