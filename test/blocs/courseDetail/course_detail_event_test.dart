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

    test('inserting isQuiz=null will throw assertionerror', () {
      expect(
          // ignore: missing_required_param
          () => CourseState(
              course: Course(), isQuiz: null, isAnswer: true, answerId: 1),
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
