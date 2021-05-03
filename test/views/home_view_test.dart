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
import 'package:bro/models/courses.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data/home_mock.dart';
import '../mock_data/resource_detail_mock.dart';
import '../mock_data/resource_list_mock.dart';
import '../mock_data/Non_Lang_courses_list_mock.dart';

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
      when(() => homeBloc.state).thenReturn(HomeSuccess(
        home: Home(header: '', introduction: ''),
      ));
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => courseListBloc),
          BlocProvider(create: (context) => resourceListBloc),
          BlocProvider(create: (context) => homeBloc),
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
    testWidgets('renders properly with courses, resources and home',
        (WidgetTester tester) async {
      var listMock = <Resources>[];
      mockedResourceList.resources.forEach((e) {
        listMock.add(e);
      });
      var successCourses =
          LangCourse.fromJson(non_lang_courses_mock['data']!['LangCourse']![0]);
      final successResources =
          ResourceList.takeList([resourceDetailMockJSON['resources'][0]])
              .resources;
      when(() => homeBloc.state).thenReturn(
        HomeSuccess(
          home: mockedHome,
        ),
      );

      // when(() => courseListBloc.state).thenReturn(
      //     CourseListSuccess(courses: [successCourses], hasReachedMax: true));

      // when(() => resourceListBloc.state)
      //     .thenReturn(ResourceListSuccess(resources: successResources));

      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<CourseListBloc>(create: (context) => courseListBloc),
          BlocProvider<ResourceListBloc>(create: (context) => resourceListBloc),
          BlocProvider<HomeBloc>(create: (context) => homeBloc),
        ],
        child: MaterialApp(home: HomeView()),
      ));

      await tester.pumpAndSettle();
      expect(find.text(mockedHome.header), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text(mockedHome.introduction), findsOneWidget);
      await tester.tap(find.text('Anbefalte Ressurser'));
      await tester.pumpAndSettle();
      expect(find.text(successResources[0].title), findsOneWidget);
      expect(find.text(successResources[0].description), findsOneWidget);
      await tester.tap(find.text('Anbefalte Kurs'));
      await tester.pumpAndSettle();
      expect(find.text(successCourses.title), findsOneWidget);
      expect(find.text(successCourses.description), findsOneWidget);
    });
  });
}
