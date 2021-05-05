import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../mock_data/course_detail_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(
        CourseDetailFailed(err: 'This is a failurestate'));
  });

  mainState();
}

void mainState() {
  group('CourseDetailState', () {
    test('should succeed when inserting course and isAnswer:false', () {
      expect(
          // ignore: missing_required_param
          CourseDetailSuccess(
              course: referenceCourse, isQuiz: true, isAnswer: false),
          isInstanceOf<CourseDetailSuccess>());
    });

    test('should succeed when inserting everything correctly', () {
      expect(
          CourseDetailSuccess(
              course: referenceCourse,
              isQuiz: true,
              isAnswer: true,
              answerId: 1),
          isInstanceOf<CourseDetailSuccess>());
    });

    test(
        'should throw assertionerror when inserting isAnswer:true and no answerId',
        () {
      expect(
          () => CourseDetailSuccess(
              course: referenceCourse, isQuiz: true, isAnswer: true),
          throwsAssertionError);
    });
  });
}
