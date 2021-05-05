import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/home.dart';
import 'package:bro/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

class MockResourceListView
    extends MockBloc<ResourceListEvent, ResourceListState>
    implements ResourceListBloc {}

class MockCourseListView extends MockBloc<CourseListEvent, CourseListState>
    implements CourseListBloc {}

class MockHomeView extends MockBloc<HomeEvent, HomeState> implements HomeBloc {
  MockHomeView();
}

class MockResourceRepository extends Mock implements ResourceRepository {}

class MockCourseRepository extends Mock implements CourseRepository {}

class MockPreferredLanguageRepository extends Mock
    implements PreferredLanguageRepository {}

class MockClient extends Mock implements GraphQLClient {
  MockClient();
}

void main() {
  setUpAll(() {
    registerFallbackValue<HomeState>(HomeFailed());
    registerFallbackValue<HomeEvent>(HomeRequested());
    registerFallbackValue<ResourceListState>(
        ResourceListFailed(err: 'Error, bad request'));
    registerFallbackValue<CourseListState>(CourseListFailed());
    registerFallbackValue<ResourceListEvent>(
        ResourceListRequested(category_id: '1'));
    registerFallbackValue<CourseListEvent>(CourseListRequested());
  });

  mainTest();
}

void mainTest() {
  group('HomeView', () {
    late HomeBloc homeBloc;
    late ResourceListBloc resourceListBloc;
    late ResourceRepository resourceRepository;
    late CourseListBloc courseListBloc;
    late CourseRepository courseRepository;
    late PreferredLanguageBloc preferredLanguageBloc;
    late PreferredLanguageRepository preferredLanguageRepository;

    setUp(() {
      homeBloc = MockHomeView();
      resourceRepository = MockResourceRepository();
      courseRepository = MockCourseRepository();
      preferredLanguageRepository = MockPreferredLanguageRepository();
      preferredLanguageBloc =
          PreferredLanguageBloc(repository: preferredLanguageRepository);
      resourceListBloc = ResourceListBloc(
          repository: resourceRepository,
          preferredLanguageBloc: preferredLanguageBloc);
      courseListBloc = CourseListBloc(
          repository: courseRepository,
          preferredLanguageBloc: preferredLanguageBloc);
    });

    tearDown(() {
      homeBloc.close();
    });

    testWidgets('renders properly without courses,resources and home',
        (WidgetTester tester) async {
      when(() => homeBloc.state)
          .thenReturn(HomeSuccess(home: Home(header: '', introduction: '')));
      when(() => preferredLanguageBloc.repository.getPreferredLangSlug())
          .thenAnswer((_) => Future.value('NO'));

      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => courseListBloc),
          BlocProvider(create: (context) => resourceListBloc),
          BlocProvider(create: (context) => homeBloc),
          BlocProvider<PreferredLanguageBloc>(
              create: (context) => preferredLanguageBloc),
          BlocProvider(
              create: (context) => HomeBloc(
                    homeRepository: HomeRepository(
                      client: MockClient(),
                    ),
                  )),
        ],
        child: MaterialApp(home: HomeView()),
      ));
    });
  });
}
