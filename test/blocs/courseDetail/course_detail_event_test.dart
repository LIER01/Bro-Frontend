import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(
        Failed(err: 'This is a failurestate'));
  });

  mainState();
}

void mainState() {
  group('CourseDetailState', () {
    test('should throw assertionerror when inserting no parameters', () {
      // ignore: missing_required_param
      expect(() => CourseState(), throwsAssertionError);
    });

    test(
        'should throw assertionerror when inserting not inserting "course" or "courseId"',
        () {
      // ignore: missing_required_param
      expect(() => CourseState(isQuiz: true, isAnswer: true, answerId: 1),
          throwsAssertionError);
    });

    test('should succeed when inserting course and isAnswer:false', () {
      expect(
          // ignore: missing_required_param
          CourseState(course: Course(), isQuiz: true, isAnswer: false),
          isInstanceOf<CourseState>());
    });

    test('should throw assertionerror when not inserting isQuiz', () {
      expect(
          // ignore: missing_required_param
          () => CourseState(course: Course(), isAnswer: true, answerId: 1),
          throwsAssertionError);
    });

    test('should throw assertionerror when inserting isQuiz=null', () {
      expect(
          // ignore: missing_required_param
          () => CourseState(
              course: Course(), isQuiz: null, isAnswer: true, answerId: 1),
          throwsAssertionError);
    });
    test('should succeed when inserting everything correctly', () {
      expect(
          CourseState(
              course: Course(), isQuiz: true, isAnswer: true, answerId: 1),
          isInstanceOf<CourseState>());
    });

    test(
        'should throw assertionerror when inserting isAnswer:true and no answerId',
        () {
      expect(() => CourseState(course: Course(), isQuiz: true, isAnswer: true),
          throwsAssertionError);
    });

    test('should throw assertionerror when inserting answerId and no isAnswer',
        () {
      expect(() => CourseState(course: Course(), isQuiz: true, answerId: 1),
          throwsAssertionError);
    });
  });
}
