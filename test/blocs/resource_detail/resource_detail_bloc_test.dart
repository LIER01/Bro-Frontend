import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data/resource_detail_mock.dart';

class MockResourceRepository extends Mock implements ResourceRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<ResourceDetailState>(Failed(err: 'This is an error'));
  });

  mainBloc();
}

void mainBloc() {
  group('ResourceDetailBloc', () {
    late ResourceRepository resourceRepository;
    late ResourceDetailBloc resourceDetailBloc;

    setUp(() {
      resourceRepository = MockResourceRepository();
      when(
        () => resourceRepository.getResource(
          any(), // lang
          any(), // group
        ),
      ).thenAnswer(
        (_) => Future.value(
          QueryResult(
            source: null,
            data: resourceDetailMockJSON,
          ),
        ),
      );
      resourceDetailBloc = ResourceDetailBloc(repository: resourceRepository);
    });

    tearDown(() {
      resourceDetailBloc.close();
    });

    blocTest(
      'should emit failed if server does not respond',
      build: () {
        when(() => resourceRepository.getResource(any(), any())).thenThrow(
          NetworkException(
            message: 'Error, connection failed.',
            uri: Uri(),
          ),
        );
        return resourceDetailBloc;
      },
      act: (ResourceDetailBloc resourceDetailBloc) async =>
          resourceDetailBloc.add(
        ResourceDetailRequested(
          group: 'resepter',
          lang: 'NO',
        ),
      ),
      expect: () => [
        isInstanceOf<Failed>(),
      ],
    );

    blocTest(
      'should emit Success when correct values are given',
      build: () => resourceDetailBloc,
      act: (ResourceDetailBloc resourceDetailBloc) async =>
          resourceDetailBloc.add(
        ResourceDetailRequested(lang: 'NO', group: 'resepter'),
      ),
      expect: () => [
        isInstanceOf<Success>(),
      ],
    );
  });
}
