import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/views/resource/resource_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data/resource_list_mock.dart';

class MockResourceListView
    extends MockBloc<ResourceListEvent, ResourceListState>
    implements ResourceListBloc {}

class MockResourceRepository extends Mock implements ResourceRepository {}

class MockPreferredLanguageRepository extends Mock
    implements PreferredLanguageRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<ResourceListState>(ResourceListFailed(err: 'WRONG'));
    registerFallbackValue<ResourceListEvent>(
        ResourceListRequested(category_id: '1'));
    registerFallbackValue<PreferredLanguageState>(
        LanguageChanged(preferredLang: 'NO'));
  });

  mainTest();
}

void mainTest() {
  group('ResourceListView', () {
    late ResourceListBloc resourceListBloc;
    late ResourceRepository resourceRepository;
    late PreferredLanguageBloc preferredLanguageBloc;
    late PreferredLanguageRepository preferredLanguageRepository;

    setUp(() {
      resourceListBloc = MockResourceListView();
      resourceRepository = MockResourceRepository();
      preferredLanguageRepository = MockPreferredLanguageRepository();
      preferredLanguageBloc =
          PreferredLanguageBloc(repository: preferredLanguageRepository);
      resourceListBloc = ResourceListBloc(
          repository: resourceRepository,
          preferredLanguageBloc: preferredLanguageBloc);
    });

    tearDown(() {
      resourceListBloc.close();
    });

    testWidgets('renders properly without resources',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider.value(
          value: resourceListBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ResourceListView(
                category_id: '1',
                category: 'familie',
              ),
            ),
          ),
        ),
      );
    });
    // ignore: omit_local_variable_types
    List<Resources> listMock = [];
    testWidgets('renders properly with resources', (WidgetTester tester) async {
      mockedResourceList.resources.forEach((e) {
        listMock.add(e);
      });

      when(() => preferredLanguageRepository.getPreferredLangSlug())
          .thenAnswer((_) => Future.value('NO'));

      when(() => resourceRepository.getFalseLangResources(any(), any(), any()))
          .thenAnswer((_) => Future.value(
              QueryResult(source: null, data: mockedResourceListRaw['data'])));
      await tester.pumpWidget(MultiBlocProvider(
          providers: [
            BlocProvider<PreferredLanguageBloc>(
                create: (context) => preferredLanguageBloc),
            BlocProvider(create: (context) => resourceListBloc),
          ],
          child: MaterialApp(
              home: Scaffold(
            body: ResourceListView(
              category_id: '1',
              category: 'familie',
            ),
          ))));

      await tester.pumpAndSettle();

      expect(find.byType(LinearProgressIndicator), findsNothing);

      await tester.pumpAndSettle();

      expect(find.text(listMock[0].title), findsOneWidget);
      expect(find.text(listMock[0].description), findsWidgets);
    });
  });
}
