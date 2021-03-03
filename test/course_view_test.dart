import 'dart:io';

import 'package:bro/views/course/CourseApp.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_data/info_card_mock.dart';
import 'utils/create_widget_for_testing.dart';
import 'utils/graphql_mutation_mocker.dart';

void main() {
  //Stops networkImage from trying to fetch with HTTP
  setUpAll(() => HttpOverrides.global = null);

  group('Test mutation', () {
    testWidgets('It should show title and description',
        (WidgetTester tester) async {
      await tester.pumpWidget(GraphQLMutationMocker(
        mockedResult: mockedResult,
        child: createWidgetForTesting(child: CourseView()),
      ));
      await tester.pump(Duration.zero);
      /* expect(find.text('yolo'), findsOneWidget); */
      expect(
          find.text(mockedResult['data']['course']['title']), findsOneWidget);
      expect(
          find.text(
            mockedResult['data']['course']['slides'][0]['description'],
          ),
          findsWidgets);
      expect(
          find.text(
            mockedResult['data']['course']['slides'][0]['title'],
          ),
          findsWidgets);
    });
  });
}
