import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResourceListState', () {
    group('ResourceListLoading', () {
      test('toString returns correct value', () {
        expect(ResourceListLoading().toString(), 'ResourceListLoading()');
      });
    });
    group('ResourceListFailed', () {
      test('toString returns correct value', () {
        expect(ResourceListFailed(err: 'WRONG').toString(),
            'ResourceListFailed(WRONG)');
      });
    });
  });
}
