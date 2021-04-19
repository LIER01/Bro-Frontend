import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/views/resource/resource_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data/course_mock.dart';

class MockCourseListView extends MockBloc<ResourceListEvent, ResourceListState>
    implements ResourceListBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<ResourceListState>(Failed());
    registerFallbackValue<ResourceListEvent>(ResourceListRequested());
  });

  mainTest();
}

void mainTest() {
  group('ResourceListView', () {
    late ResourceListBloc courseListBloc;

    setUp(() {
      courseListBloc = MockResourceListView();
    });

    tearDown(() {
      courseListBloc.close();
    });

    testWidgets('renders properly without courses',
        (WidgetTester tester) async {
      when(() => courseListBloc.state).thenReturn(Success(resources: []));
      await tester.pumpWidget(
        BlocProvider.value(
          value: courseListBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ResourceListView(
                category_id: '1',
                category: 'familie',
              ),
            ),
          ),
        ),
      );
    });
    List<LangResource> mockedLangCourseList;
    testWidgets('renders properly with courses', (WidgetTester tester) async {
      mockedLangCourseList = [];
      mockedCourseList.forEach((element) {
        mockedLangCourseList.add(LangResource.fromJson(element));
      });
      when(() => courseListBloc.state).thenReturn(
          Success(courses: mockedLangResourceList, hasReachedMax: true));
      await tester.pumpWidget(
        BlocProvider.value(
          value: courseListBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ResourceListView(),
            ),
          ),
        ),
      );
      await tester.pump();
      debugPrint(mockedLangResourceList[0].title);

      expect(find.byType(LinearProgressIndicator), findsNothing);

      expect(find.text(mockedLangResourceList[0].title), findsOneWidget);
      expect(find.text(mockedLangResourceList[0].description), findsWidgets);
    });
  });
}
