import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/views/resource/resource_detail/resource_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../blocs/resource_detail/resource_detail_bloc_test.dart';
import '../mock_data/resource_detail_mock.dart';

class MockResourceDetailBloc
    extends MockBloc<ResourceDetailEvent, ResourceDetailState>
    implements ResourceDetailBloc {}

class MockResourceRepository extends Mock implements ResourceRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<ResourceDetailState>(Failed(
      err: 'Failed.',
    ));
    registerFallbackValue<ResourceDetailEvent>(ResourceDetailRequested(
      lang: 'NO',
      group: 'resepter',
    ));
  });

  mainTest();
}

void mainTest() {
  group('ResourceDetailView', () {
    ResourceRepository resourceRepository;
    late ResourceDetailBloc resourceDetailBloc;

    setUp(() {
      resourceRepository = MockResourceRepository();
      when(() => resourceRepository.getResource(
            any(),
            any(),
          )).thenAnswer(
        (_) => Future.value(
          QueryResult(
            source: null,
            data: resourceDetailMockJSON,
          ),
        ),
      );
      resourceDetailBloc = MockResourceDetailBloc();
    });

    tearDown(() {
      resourceDetailBloc.close();
    });

    testWidgets('renders properly with inserted data',
        (WidgetTester tester) async {
      when(() => resourceDetailBloc.state).thenAnswer((_) => Success(
            resource: resourceDetailMock,
          ));
      tester.binding.window.physicalSizeTestValue = Size(600, 1920);
      await tester.pumpWidget(
        BlocProvider.value(
          value: resourceDetailBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ResourceDetailView(lang: 'NO', group: 'resepter'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Resepter'), findsOneWidget);
      expect(find.text('NHI Hvit Resept'), findsOneWidget);
      expect(find.text('Status rapport'), findsOneWidget);
    });
  });
}
