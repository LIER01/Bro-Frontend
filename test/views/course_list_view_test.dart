import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/models/reduced_course.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseListView extends MockBloc<CourseListEvent, CourseListState>
    implements CourseListBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<CourseListState>(Failed());
    registerFallbackValue<CourseListEvent>(CourseListRequested());
  });

  mainTest();
}

void mainTest() {
  group('CourseListView', () {
    late CourseListBloc courseListBloc;

    setUp(() {
      courseListBloc = MockCourseListView();
    });

    tearDown(() {
      courseListBloc.close();
    });

    testWidgets('renders properly without courses',
        (WidgetTester tester) async {
      when(() => courseListBloc.state)
          .thenReturn(Success(courses: [], hasReachedMax: true));
      await tester.pumpWidget(
        BlocProvider.value(
          value: courseListBloc,
          child: MaterialApp(
            home: Scaffold(
              body: CourseListView(),
            ),
          ),
        ),
      );
    });

    testWidgets('renders properly with courses', (WidgetTester tester) async {
      when(() => courseListBloc.state).thenReturn(
        Success(courses: [
          ReducedCourse(
            id: 1,
            title: 'Kurstittel',
            description: 'Kursbeskrivelse',
            slides: [
              Slide(id: 1),
            ],
            questions: [
              Question(id: 1),
            ],
          )
        ], hasReachedMax: true),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: courseListBloc,
          child: MaterialApp(
            home: Scaffold(
              body: CourseListView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Kurstittel'), findsOneWidget);
      expect(find.text('Kursbeskrivelse'), findsOneWidget);
    });
  });
}
