import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/models/course.dart';
import 'package:bro/views/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../mock_data/course_detail_mock.dart';

import '../mock_data/new_course_mock.dart';

class MockCourseDetailBloc
    extends MockBloc<CourseDetailEvent, CourseDetailState>
    implements CourseDetailBloc {}

class MockCourseRepository extends Mock implements CourseRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(Failed(err: 'Failed'));
    registerFallbackValue<CourseDetailEvent>(CourseDetailRequested(
        courseGroupSlug: 'k1', isAnswer: false, isQuiz: false));
  });

  mainTest();
}

void mainTest() {
  group('CourseDetailView', () {
    CourseRepository courseRepository;
    late CourseDetailBloc courseDetailBloc;
    late Course refCourse;

    setUp(() {
      courseRepository = MockCourseRepository();
      when(() => courseRepository.getCourse(any())).thenAnswer((_) =>
          Future.value(QueryResult(source: null, data: course_detail_mock)));
      courseDetailBloc = MockCourseDetailBloc();
      refCourse = referenceCourse;
    });

    tearDown(() {
      courseDetailBloc.close();
    });

    testWidgets('renders properly with inserted data',
        (WidgetTester tester) async {
      when(() => courseDetailBloc.state).thenAnswer((_) => CourseState(
          course: referenceCourses, isQuiz: false, isAnswer: false));
      await tester.pumpWidget(
        BlocProvider.value(
          value: courseDetailBloc,
          child: MaterialApp(
            home: Scaffold(
              body: CourseDetailView(
                courseGroup: 'k1',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.text('En meget fin testcourse'), findsOneWidget);
    });
  });
}
