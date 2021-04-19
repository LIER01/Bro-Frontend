import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data/resource_detail_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<ResourceDetailState>(
        Failed(err: 'This is a failurestate'));
  });

  mainState();
}

void mainState() {
  group('ResourceDetailState', () {
    test('should succeed when inserting resources', () {
      expect(
        Success(resource: resourceDetailMock),
        isInstanceOf<Success>(),
      );
    });

    test('should fail when mssing nullable fields', () {});
  });
}
