import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CourseListEvents', () {
    group('CourseListRequested', () {
      test('toString returns correct value', () {
        expect(CourseListRequested().toString(), 'CourseListRequested(NO)');
      });
    });
  });
}
