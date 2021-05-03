import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/models/courses.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../mock_data/course_list_mock.dart';

class MockCourseListView extends MockBloc<CourseListEvent, CourseListState>
    implements CourseListBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<CourseListState>(CourseListFailed());
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
          .thenReturn(CourseListSuccess(courses: [], hasReachedMax: true));
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
    List<ReducedCourse> mockedLangCourseList;
    testWidgets('renders properly with courses', (WidgetTester tester) async {
      mockedLangCourseList = [];
      mockCourseList.forEach((element) {
        mockedLangCourseList.add(ReducedCourse.fromJson(element));
      });
      when(() => courseListBloc.state).thenReturn(CourseListSuccess(
          courses: mockedLangCourseList, hasReachedMax: true));
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
      await tester.pump();

      expect(find.byType(LinearProgressIndicator), findsNothing);

      expect(find.text(mockedLangCourseList[0].title), findsOneWidget);
      expect(find.text(mockedLangCourseList[0].description), findsWidgets);
    });
  });
}
