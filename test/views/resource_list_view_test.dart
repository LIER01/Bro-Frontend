import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/views/resource/resource_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data/resource_list_mock.dart';

class MockResourceListView
    extends MockBloc<ResourceListEvent, ResourceListState>
    implements ResourceListBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<ResourceListState>(Failed(err: "WRONG"));
    registerFallbackValue<ResourceListEvent>(
        ResourceListRequested(category_id: '1', lang: 'NO'));
  });

  mainTest();
}

void mainTest() {
  group('ResourceListView', () {
    late ResourceListBloc resourceListBloc;

    setUp(() {
      resourceListBloc = MockResourceListView();
    });

    tearDown(() {
      resourceListBloc.close();
    });

    testWidgets('renders properly without resources',
        (WidgetTester tester) async {
      when(() => resourceListBloc.state).thenReturn(Success(resources: []));
      await tester.pumpWidget(
        BlocProvider.value(
          value: resourceListBloc,
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
    List<Resources> listMock = [];
    testWidgets('renders properly with resources', (WidgetTester tester) async {
      mockedResourceList.resources.forEach((e) {
        listMock.add(e);
      });
      when(() => resourceListBloc.state)
          .thenReturn(Success(resources: listMock));
      await tester.pumpWidget(
        BlocProvider.value(
          value: resourceListBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ResourceListView(
                category_id: '1',
                category: 'NO',
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(LinearProgressIndicator), findsNothing);

      expect(find.text(listMock[0].title), findsOneWidget);
      expect(find.text(listMock[0].description), findsWidgets);
    });
  });
}
