import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCourseListView extends MockBloc<CourseListEvent>
    implements CourseListBloc {}

void main() {
  group('CourseListView', () {
    CourseListBloc courseListBloc;

    setUp(() {
      courseListBloc = MockCourseListView();
    });

    tearDown(() {
      courseListBloc.close();
    });

    testWidgets('renders properly without courses',
        (WidgetTester tester) async {
      when(courseListBloc.state)
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
      when(courseListBloc.state).thenReturn(
        Success(courses: [
          Course(
            title: 'Kurstittel',
            description: 'Kursbeskrivelse',
            slides: [
              {},
            ],
            questions: [
              {},
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
