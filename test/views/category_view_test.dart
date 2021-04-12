import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/blocs/category/category_event.dart';
import 'package:bro/models/category.dart';
import 'package:bro/views/category/category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoryView extends MockBloc<CategoryEvent, CategoryState>
    implements CategoryBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<CategoryState>(Failed());
    registerFallbackValue<CategoryEvent>((CategoriesRequested()));
  });

  mainTest();
}

void mainTest() {
  group('CategoryView', () {
    CategoryBloc categoryBloc;

    setUp(() {
      categoryBloc = MockCategoryView();
    });

    tearDown(() {
      categoryBloc.close();
    });

    testWidgets('renders properly without categories',
        (WidgetTester tester) async {
      when(() => categoryBloc.state).thenReturn(
        Success(
          categories: [],
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: categoryBloc,
          child: MaterialApp(
            home: Scaffold(
              body: CategoryView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Ingen tilgjengelige kategorier'), findsOneWidget);
    });

    testWidgets('renders properly with categories',
        (WidgetTester tester) async {
      when(() => categoryBloc.state).thenReturn(
        Success(
          categories: [
            Category(name: 'Testkategori', cover_photo: '/image.url.png')
          ],
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: categoryBloc,
          child: MaterialApp(
            home: Scaffold(
              body: CategoryView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Testkategori'), findsOneWidget);
    });
  });
}
