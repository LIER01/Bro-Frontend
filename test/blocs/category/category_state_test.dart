import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/models/category.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryState', () {
    group('CategoryLoading', () {
      test('toString returns correct value', () {
        expect(Loading().toString(), 'Loading()');
      });
    });

    group('CategorySuccess', () {
      final category = Category(
        category_name: 'Kategori',
        category_id: '1',
        description: 'Testbeskrivelse',
        cover_photo: CoverPhoto(url: 'Test'),
      );

      test('toString returns correct value', () {
        expect(Success(categories: [category]).toString(),
            'Success { categories: [$category] }');
      });
    });

    group('CategoryFailed', () {
      test('toString returns correct value', () {
        expect(Failed().toString(), 'Failed()');
      });
    });
  });
}
