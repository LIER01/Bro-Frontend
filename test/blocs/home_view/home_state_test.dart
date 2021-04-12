import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/models/new_courses.dart';
import 'package:bro/models/reduced_course.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data/Lang_courses_mock.dart';
import '../../mock_data/home_mock.dart';
import '../../mock_data/course_mock.dart';

import '../../mock_data/new_course_mock.dart';

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
      final successCourse = ReducedCourse.fromJson(mockedResult['courses'][0]);
      test('toString returns correct value', () {
        expect(
            Success(
                    courses: [LangCourse.fromJson(new_mock_courses)],
                    hasReachedMax: false,
                    home: home)
                .toString(),
            'Success { courses: [$successCourse], hasReachedMax: false, home: $home }');
      });
    });
    group('HomeFailed', () {
      test('toString returns correct value', () {
        expect(Failed().toString(), 'Failed()');
      });
    });
  });
}
