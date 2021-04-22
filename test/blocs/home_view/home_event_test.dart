import 'package:bro/blocs/home/home_bucket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeEvent', () {
    group('HomeRequested', () {
      test('toString returns correct value', () {
        expect(HomeRequested().toString(), 'HomeRequested()');
      });
    });
  });
}
