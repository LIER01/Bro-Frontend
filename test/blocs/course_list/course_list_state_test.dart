import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CourseListState', () {
    group('CourseListInitial', () {
      test('toString returns correct value', () {
        expect(InitialCourseList().toString(), 'InitialCourseList()');
      });
    });

    group('CourseListLoading', () {
      test('toString returns correct value', () {
        expect(Loading().toString(), 'Loading()');
      });
    });
    group('CourseListFailed', () {
      test('toString returns correct value', () {
        expect(CourseListFailed().toString(), 'CourseListFailed()');
      });
    });
  });
}
