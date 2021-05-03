import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../mock_data/course_detail_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailEvent>(CourseDetailRequested(
        courseGroupSlug: 'k1', isQuiz: false, isAnswer: false));
  });

  mainEvent();
}

void mainEvent() {
  group('CourseDetailRequested', () {
    test(
        'should throws assertionerror when inserting "isAnswer":true but not inserting answerId',
        () {
      expect(
          () => CourseDetailRequested(
              courseGroupSlug: 'k1', isQuiz: true, isAnswer: true),
          throwsAssertionError);
    });

    test('should succeed when inserting "isAnswer and answerId ', () {
      expect(
          CourseDetailRequested(
              courseGroupSlug: 'k1', isQuiz: true, isAnswer: true, answerId: 1),
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
      expect(
          CourseDetailRequested(
              courseGroupSlug: 'k1', isQuiz: true, isAnswer: false),
          isInstanceOf<CourseDetailRequested>());
    });

    test(
        'should return instance of CourseDetailRequested when passing course but not courseId',
        () {
      expect(
          CourseDetailRequested(
              course: referenceCourse, isQuiz: true, isAnswer: false),
          isInstanceOf<CourseDetailRequested>());
    });

    test(
        'should return instance of CourseDetailRequested should when inserting everything correctly',
        () {
      expect(
          CourseDetailRequested(
              course: referenceCourse,
              courseGroupSlug: 'k1',
              isQuiz: true,
              isAnswer: true,
              answerId: 1),
          isInstanceOf<CourseDetailRequested>());
    });
  });
}
