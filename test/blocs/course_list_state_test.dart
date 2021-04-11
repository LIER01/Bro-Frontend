import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/models/reduced_course.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CourseListState', () {
    group('CourseListInitial', () {
      test('toString returns correct value', () {
        expect(Initial().toString(), 'Initial()');
      });
    });

    group('CourseListLoading', () {
      test('toString returns correct value', () {
        expect(Loading().toString(), 'Loading()');
      });
    });
    group('CourseListSuccess', () {
      final course = ReducedCourse(
          id: 1,
          title: 'Tittel',
          description: 'Beskrivelse av kurs.',
          questions: [Question(id: 1)],
          slides: [Slide(id: 1)]);
      test('toString returns correct value', () {
        expect(Success(courses: [course], hasReachedMax: false).toString(),
            'Success { courses: [$course], hasReachedMax: false }');
      });
    });
    group('CourseListFailed', () {
      test('toString returns correct value', () {
        expect(Failed().toString(), 'Failed()');
      });
    });
  });
}
