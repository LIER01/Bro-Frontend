import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/models/courses.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mock_data/Non_Lang_courses_list_mock.dart';
import '../../mock_data/home_mock.dart';
import '../../mock_data/resource_detail_mock.dart';

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
      final home = mockedHome;
      final successCourse =
          LangCourseList.takeList(non_lang_courses_mock['data']!['LangCourse']!)
              .langCourses;
      final successResources =
          ResourceList.takeList([resourceDetailMockJSON]).resources;
      test('toString returns correct value', () {
        expect(
            HomeSuccess(
                    courses: successCourse,
                    home: home,
                    resources: successResources)
                .toString(),
            'Success { courses: $successCourse, home: $home, resources: $successResources}');
      });
    });
    group('HomeFailed', () {
      test('toString returns correct value', () {
        expect(HomeFailed().toString(), 'HomeFailed()');
      });
    });
  });
}
