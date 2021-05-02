import 'package:bro/blocs/resource_list/resource_list_bucket.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResourceListEvents', () {
    group('ResourceListRequested', () {
      test('toString returns correct value', () {
        expect(ResourceListRequested(category_id: '1').toString(),
            'ResourceListRequested(NO)');
      });
    });
  });
}
