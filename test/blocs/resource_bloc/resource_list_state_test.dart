import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResourceListState', () {
    group('ResourceListLoading', () {
      test('toString returns correct value', () {
        expect(Loading().toString(), 'Loading()');
      });
    });
    // group('CourseListSuccess', () {
    //   final course = ReducedCourse(
    //       id: 1,
    //       title: 'Tittel',
    //       description: 'Beskrivelse av kurs.',
    //       questions: [Question(id: 1)],
    //       slides: [Slide(id: 1)]);
    //   test('toString returns correct value', () {
    //     expect(Success(courses: [course], hasReachedMax: false).toString(),
    //         'Success { courses: [$course], hasReachedMax: false }');
    //   });
    // });
    group('ResourceListFailed', () {
      test('toString returns correct value', () {
        expect(Failed(err: 'WRONG').toString(), 'Failed(WRONG)');
      });
    });
  });
}
