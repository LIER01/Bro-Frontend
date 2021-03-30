import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../mock_data/course_detail_mock.dart';
import 'package:bro/data/course_repository.dart';

class MockCourseDetailRepository extends Mock implements CourseRepository {}

var mockedCourse = course_detail_mock['data']['course'];
void main() {
  setUpAll(() {
    registerFallbackValue<CourseDetailState>(Failed(err: 'This is an error'));
    registerFallbackValue<CourseDetailEvent>(
        CourseDetailRequested(courseId: 1, isQuiz: false, isAnswer: false));
  });
}