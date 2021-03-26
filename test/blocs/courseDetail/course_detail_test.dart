import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/category_repository.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';
import '../../mock_data/course_detail_mock.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bro/data/course_repository.dart';

class MockCourseDetailRepository extends Mock implements CourseRepository {}

var mockedCourse = course_detail_mock['data']['course'];
void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(Failed());
    registerFallbackValue<CourseDetailEvent>(
        CourseDetailRequested(courseId: 1, isQuiz: false, isAnswer: false));
  });

  //mainBloc();
  mainState();
  mainEvent();
}

void mainState() {
  group('CourseDetailState', () {
    test('inserting no parameters throws assertionerror', () {
      expect(() => CourseState(), throwsAssertionError);
    });

    test('not inserting "course" throws assertionerror', () {
      // ignore: missing_required_param
      expect(() => CourseState(isQuiz: true, isAnswer: true, answerId: 1),
          throwsAssertionError);
    });

    test('inserting course and isAnswer:false does succeed', () {
      expect(
          // ignore: missing_required_param
          CourseState(course: Course(), isQuiz: true, isAnswer: false),
          isInstanceOf<CourseState>());
    });

    test('not inserting isQuiz will throw assertionerror', () {
      expect(
          // ignore: missing_required_param
          () => CourseState(course: Course(), isAnswer: true, answerId: 1),
          throwsAssertionError);
    });
    test('inserting everything correctly succeeds', () {
      expect(
          CourseState(
              course: Course(), isQuiz: true, isAnswer: true, answerId: 1),
          isInstanceOf<CourseState>());
    });

    test('inserting isAnswer:true and no answerId will throw assertionerror',
        () {
      expect(() => CourseState(course: Course(), isQuiz: true, isAnswer: true),
          throwsAssertionError);
    });

    test('inserting answerId and no isAnswer will throw assertionerror', () {
      expect(() => CourseState(course: Course(), isQuiz: true, answerId: 1),
          throwsAssertionError);
    });
  });
}

void mainEvent() {
  group('CourseDetailRequested', () {
    test('inserting no parameters throws assertionerror', () {
      // ignore: missing_required_param
      expect(() => CourseDetailRequested(), throwsAssertionError);
    });

    test(
        'inserting "isAnswer":true but not inserting answerId throws assertionerror',
        () {
      expect(
          () =>
              CourseDetailRequested(courseId: 1, isQuiz: true, isAnswer: true),
          throwsAssertionError);
    });

    test('inserting "isAnswer and answerId succeeds', () {
      expect(
          CourseDetailRequested(
              courseId: 1, isQuiz: true, isAnswer: true, answerId: 1),
          isInstanceOf<CourseDetailRequested>());
    });

    test('not inserting courseId or course throws assertionerror', () {
      expect(() => CourseDetailRequested(isQuiz: true, isAnswer: false),
          throwsAssertionError);
    });

    test('passing courseId but not course succeeds', () {
      expect(CourseDetailRequested(courseId: 1, isQuiz: true, isAnswer: false),
          isInstanceOf<CourseDetailRequested>());
    });

    test('passing course but not courseId succeeds', () {
      expect(
          CourseDetailRequested(
              course: Course(), isQuiz: true, isAnswer: false),
          isInstanceOf<CourseDetailRequested>());
    });

    test('inserting everything correctly succeeds', () {
      expect(
          CourseDetailRequested(
              course: Course(),
              courseId: 1,
              isQuiz: true,
              isAnswer: true,
              answerId: 1),
          isInstanceOf<CourseDetailRequested>());
    });
  });
}
