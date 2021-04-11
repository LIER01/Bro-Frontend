import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/models/reduced_course.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data/home_mock.dart';
import '../../mock_data/course_mock.dart';

void main() {
  group('HomeState', () {
    group('HomeInitial', () {
      test('toString returns correct value', () {
        expect(Initial().toString(), 'Initial()');
      });
    });

    group('HomeLoading', () {
      test('toString returns correct value', () {
        expect(Loading().toString(), 'Loading()');
      });
    });
    group('HomeViewSuccess', () {
      final course = mockedCourse;
      final home = mockedHome;
      test('toString returns correct value', () {
        expect(
            Success(
                    courses: [mockedResult as ReducedCourse],
                    hasReachedMax: false,
                    home: home)
                .toString(),
            'Success { courses: [$course], hasReachedMax: false, home: $home }');
      });
    });
    group('HomeFailed', () {
      test('toString returns correct value', () {
        expect(Failed().toString(), 'Failed()');
      });
    });
  });
}
