import 'package:bro/views/course/course_list_view.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_data/course_mock.dart';
import 'utils/create_widget_for_testing.dart';
import 'utils/graphql_mutation_mocker.dart';

void main() {
  group('Test CourseView', () {
    testWidgets('It should show a list courses', (WidgetTester tester) async {
      await tester.pumpWidget(GraphQLMutationMocker(
        mockedResult: mockedResult,
        child: createWidgetForTesting(child: CourseListView()),
      ));
      await tester.pump(Duration.zero);
      expect(
          find.text(mockedResult['data']['course']['title']), findsOneWidget);
      expect(find.text(mockedResult['data']['course']['description']),
          findsOneWidget);
    });
  });
}
