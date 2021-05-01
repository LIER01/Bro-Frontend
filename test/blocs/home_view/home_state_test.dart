import 'package:bro/blocs/home/home_bucket.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mock_data/home_mock.dart';

void main() {
  group('HomeState', () {
    group('HomeInitial', () {
      test('toString returns correct value', () {
        expect(Initial().toString(), 'Initial()');
      });
    });

    group('HomeLoading', () {
      test('toString returns correct value', () {
        expect(HomeLoading().toString(), 'Loading()');
      });
    });
    group('HomeViewSuccess', () {
      final home = mockedHome;
      test('toString returns correct value', () {
        expect(
            HomeSuccess(
              home: home,
            ).toString(),
            'Success { home: $home}');
      });
    });
    group('HomeFailed', () {
      test('toString returns correct value', () {
        expect(Failed().toString(), 'Failed()');
      });
    });
  });
}
