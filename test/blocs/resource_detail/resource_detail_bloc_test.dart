import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data/resource_detail_mock.dart';

class MockResourceRepository extends Mock implements ResourceRepository {}

class MockPreferredLanguageRepository extends Mock
    implements PreferredLanguageRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<ResourceDetailState>(
        ResourceDetailFailed(err: 'This is an error'));
  });

  mainBloc();
}

void mainBloc() {
  group('ResourceDetailBloc', () {
    late ResourceRepository resourceRepository;
    late ResourceDetailBloc resourceDetailBloc;
    late PreferredLanguageBloc preferredLanguageBloc;
    late PreferredLanguageRepository preferredLanguageRepository;

    setUp(() {
      resourceRepository = MockResourceRepository();
      preferredLanguageRepository = MockPreferredLanguageRepository();
      preferredLanguageBloc =
          PreferredLanguageBloc(repository: preferredLanguageRepository);
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
      resourceDetailBloc = ResourceDetailBloc(
          repository: resourceRepository,
          preferredLanguageBloc: preferredLanguageBloc);
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
        isInstanceOf<ResourceDetailLoading>(),
        isInstanceOf<ResourceDetailFailed>(),
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
        isInstanceOf<ResourceDetailLoading>(),
        isInstanceOf<ResourceDetailSuccess>(),
      ],
    );
  });
}
