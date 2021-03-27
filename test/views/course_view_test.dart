import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:bro/views/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseView extends MockBloc<CourseDetailEvent, CourseDetailState>
    implements CourseDetailBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(Failed());
    registerFallbackValue<CourseDetailEvent>(
        CourseDetailRequested(isAnswer: false, isQuiz: false));
  });

  mainTest();
}

void mainTest() {
  group('CourseListView', () {
    CourseDetailBloc courseListBloc;

    setUp(() {
      courseListBloc = MockCourseView();
    });

    tearDown(() {
      courseListBloc.close();
    });

    testWidgets('renders properly without courses',
        (WidgetTester tester) async {
      when(() => courseListBloc.state)
          //Must pass it course
          .thenReturn(CourseState(
              isQuiz: false,
              isAnswer: false,
              course: Course(
                title: 'Kurstittel',
                description: 'Kursbeskrivelse',
                slides: [
                  {},
                ],
                questions: [
                  {},
                ],
              )));
      await tester.pumpWidget(
        BlocProvider.value(
          value: courseListBloc,
          child: MaterialApp(
            home: Scaffold(
              body: CourseDetailView(),
            ),
          ),
        ),
      );
    });
  });
}
