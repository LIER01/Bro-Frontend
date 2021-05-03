import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(
    () {
      registerFallbackValue<ResourceDetailEvent>(
        ResourceDetailRequested(
          group: 'resepter',
        ),
      );
    },
  );

  mainEvent();
}

void mainEvent() {
  group(
    'ResourceDetailRequested',
    () {
      test(
        'should succeed when inserting correct arguments',
        () {
          expect(
            ResourceDetailRequested(
              group: 'resepter',
            ),
            isInstanceOf<ResourceDetailRequested>(),
          );
        },
      );
    },
  );
}
