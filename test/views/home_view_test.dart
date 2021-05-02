import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/models/home.dart';
import 'package:bro/models/courses.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data/Non_Lang_courses_list_mock.dart';
import '../mock_data/home_mock.dart';
import '../mock_data/resource_detail_mock.dart';

class MockHomeView extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<HomeState>(HomeFailed());
    registerFallbackValue<HomeEvent>(HomeRequested());
  });

  mainTest();
}

void mainTest() {
  group('HomeView', () {
    late HomeBloc homeViewBloc;

    setUp(() {
      homeViewBloc = MockHomeView();
    });

    tearDown(() {
      homeViewBloc.close();
    });

    testWidgets('renders properly without courses,resources and home',
        (WidgetTester tester) async {
      when(() => homeViewBloc.state).thenReturn(HomeSuccess(
        home: Home(header: '', introduction: ''),
      ));
      await tester.pumpWidget(
        BlocProvider.value(
          value: homeViewBloc,
          child: MaterialApp(
            home: Scaffold(
              body: HomeView(),
            ),
          ),
        ),
      );
    });

    testWidgets('renders properly with courses, resources and home',
        (WidgetTester tester) async {
      var successCourses =
          LangCourse.fromJson(non_lang_courses_mock['data']!['LangCourse']![0]);
      final successResources =
          ResourceList.takeList([resourceDetailMockJSON['resources'][0]])
              .resources;
      when(() => homeViewBloc.state).thenReturn(
        HomeSuccess(
          home: mockedHome,
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: homeViewBloc,
          child: MaterialApp(
            home: Scaffold(
              body: HomeView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(mockedHome.header), findsOneWidget);
      expect(find.text(mockedHome.introduction), findsOneWidget);
      await tester.tap(find.text('Anbefalte Ressurser'));
      expect(find.text(successResources[0].title), findsOneWidget);
      expect(find.text(successResources[0].description), findsOneWidget);
      await tester.tap(find.text('Anbefalte Kurs'));
      expect(find.text(successCourses.title), findsOneWidget);
      expect(find.text(successCourses.description), findsOneWidget);
    });
  });
}
