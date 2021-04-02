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
    test('should throw assertionerror when inserting no parameters', () {
      // ignore: missing_required_param
      expect(() => CourseDetailRequested(), throwsAssertionError);
    });

    test(
        'should throws assertionerror when inserting "isAnswer":true but not inserting answerId',
        () {
      expect(
          () =>
              CourseDetailRequested(courseId: 1, isQuiz: true, isAnswer: true),
          throwsAssertionError);
    });

    test('should succeed when inserting "isAnswer and answerId ', () {
      expect(
          CourseDetailRequested(
              courseId: 1, isQuiz: true, isAnswer: true, answerId: 1),
          isInstanceOf<CourseDetailRequested>());
    });

    test(
        'should return instance of CourseDetailRequested when inserting courseId or course',
        () {
      expect(() => CourseDetailRequested(isQuiz: true, isAnswer: false),
          throwsAssertionError);
    });

    test(
        'should return instance of CourseDetailRequested when passing courseId but not course',
        () {
      expect(CourseDetailRequested(courseId: 1, isQuiz: true, isAnswer: false),
          isInstanceOf<CourseDetailRequested>());
    });

    test(
        'should return instance of CourseDetailRequested when passing course but not courseId',
        () {
      expect(
          CourseDetailRequested(
              course: Course(), isQuiz: true, isAnswer: false),
          isInstanceOf<CourseDetailRequested>());
    });

    test(
        'should return instance of CourseDetailRequested should when inserting everything correctly',
        () {
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
