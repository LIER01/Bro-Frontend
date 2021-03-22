import 'package:bro/views/home_view/home_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_data/home_mock.dart';
import '../utils/create_widget_for_testing.dart';
import '../utils/graphql_mutation_mocker.dart';

void main() {
  group('Test HomeView', () {
    testWidgets('It should show the the header and introduction text',
        (WidgetTester tester) async {
      await tester.pumpWidget(GraphQLMutationMocker(
        mockedResult: mockedResult,
        child: createWidgetForTesting(child: HomeView()),
      ));
      await tester.pump(Duration.zero);
      expect(find.text(mockedResult['data']['home']['header']), findsOneWidget);
      expect(find.text(mockedResult['data']['home']['introduction']),
          findsOneWidget);
    });
  });
}
