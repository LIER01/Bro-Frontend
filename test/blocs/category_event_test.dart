import 'package:bro/blocs/category/category_bucket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryEvent', () {
    group('CategoryRequested', () {
      test('toString returns correct value', () {
        expect(CategoriesRequested().toString(), 'CategoriesRequested()');
      });
    });
  });
}
