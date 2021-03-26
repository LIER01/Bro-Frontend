import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailEvent>(
        CourseDetailRequested(courseId: 1, isQuiz: false, isAnswer: false));
  });

  mainEvent();
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
