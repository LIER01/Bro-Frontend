import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/views/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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

    setUp(() {
      courseRepository = MockCourseRepository();
      courseDetailBloc = MockCourseDetailBloc();
    });

    tearDown(() {
      courseDetailBloc.close();
    });

    testWidgets('renders properly with inserted data',
        (WidgetTester tester) async {
      when(() => courseDetailBloc.state).thenAnswer((_) => CourseState(
          course: referenceCourses, isQuiz: false, isAnswer: false));
      tester.binding.window.physicalSizeTestValue = Size(600, 1920);
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

      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.text(referenceCourses.title), findsOneWidget);
      expect(find.text(referenceCourses.slides[0].title), findsOneWidget);
    });
    testWidgets('navigation arrows and start quiz appears on last slide',
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
            )),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(referenceCourses.slides[0].title), findsOneWidget);
      expect(find.text(referenceCourses.slides[1].title), findsNothing);
      expect(
          // FontAwesome does not support byIcon
          find.byWidgetPredicate((Widget widget) =>
              widget is FaIcon &&
              widget.icon == FontAwesomeIcons.chevronCircleRight),
          findsOneWidget);
      await tester.tap(find.byWidgetPredicate((Widget widget) =>
          widget is FaIcon &&
          widget.icon == FontAwesomeIcons.chevronCircleRight));
      await tester.pumpAndSettle();
      await tester.tap(find.byWidgetPredicate((Widget widget) =>
          widget is FaIcon &&
          widget.icon == FontAwesomeIcons.chevronCircleRight));
      await tester.pumpAndSettle();
      expect(find.text(referenceCourses.slides[2].title), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
