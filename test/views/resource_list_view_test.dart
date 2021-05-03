import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/views/resource/resource_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockResourceListBloc
    extends MockBloc<ResourceListEvent, ResourceListState>
    implements ResourceListBloc {}

class MockResourceRepository extends Mock implements ResourceRepository {}

class MockPreferredLanguageRepository extends Mock
    implements PreferredLanguageRepository {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  setUpAll(() {
    registerFallbackValue<ResourceListState>(ResourceListFailed(err: 'WRONG'));
    registerFallbackValue<ResourceListEvent>(
        ResourceListRequested(category_id: '1'));
    registerFallbackValue<PreferredLanguageState>(
        LanguageChanged(preferredLang: 'NO'));
    registerFallbackValue<BuildContext>(FakeBuildContext());
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
      resourceListBloc = MockResourceListBloc();
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
      when(() => preferredLanguageRepository.getPreferredLangSlug())
          .thenAnswer((_) => Future.value('NO'));
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<ResourceListBloc>(create: (context) => resourceListBloc),
          BlocProvider<PreferredLanguageBloc>(
              create: (context) => preferredLanguageBloc),
        ],
        child: MaterialApp(
            home: ResourceListView(
          category_id: '1',
          category: 'familie',
        )),
      ));
    });
  });
}
