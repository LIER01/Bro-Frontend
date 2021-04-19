import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data/course_mock.dart';
import '../../mock_data/resource_list_mock.dart';

class MockResourceRepository extends Mock implements ResourceRepository {}

void main() {
  group('ResourceListBloc', () {
    late ResourceRepository resourceRepository;
    late ResourceListBloc resourceListBloc;

    setUp(() {
      resourceRepository = MockResourceRepository();
      when(() => resourceRepository.getLangResources('NO', '1')).thenAnswer(
          (_) =>
              Future.value(QueryResult(source: null, data: mockedCourseMap)));
      resourceListBloc = ResourceListBloc(repository: resourceRepository);
    });

    blocTest(
      'should emit Failed if repository throws',
      build: () {
        when(() => resourceRepository.getResource('NO', '1'))
            .thenThrow(Exception('Woops'));
        return resourceListBloc;
      },
      act: (ResourceListBloc bloc) async =>
          bloc.add(ResourceListRequested(lang: 'NOs', category_id: '1')),
      expect: () => <ResourceListState>[Failed(err: 'Error, bad request')],
    );

    blocTest(
      'initial state is correct',
      build: () => resourceListBloc,
      expect: () => <ResourceListState>[],
    );

    blocTest(
      'should load items with correct input',
      build: () {
        when(() => resourceRepository.getLangResources('NO', '1')).thenAnswer(
            (_) => Future.value(QueryResult(
                source: null, data: mockedResourceListRaw['data'])));
        return resourceListBloc;
      },
      act: (ResourceListBloc bloc) async =>
          bloc.add(ResourceListRequested(lang: 'NO', category_id: '1')),
      expect: () => [
        isA<Success>(),
      ],
    );
  });
}
