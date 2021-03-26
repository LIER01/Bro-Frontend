import 'package:bloc_test/bloc_test.dart';
import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/data/category_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';

import '../mock_data/category_mock.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() async {
  // For DotEnv
  TestWidgetsFlutterBinding.ensureInitialized();
  await DotEnv.load();

  group('CategoryBloc', () {
    CategoryRepository categoryRepository;
    CategoryBloc categoryBloc;

    setUp(() {
      categoryRepository = MockCategoryRepository();
      when(categoryRepository.getCategories()).thenAnswer(
          (_) => Future.value(QueryResult(source: null, data: mockedResult)));
      categoryBloc = CategoryBloc(repository: categoryRepository);
    });

    blocTest(
      'should emit Failed if repository throws',
      build: () {
        when(categoryRepository.getCategories()).thenThrow(Exception('Woops'));
        return categoryBloc;
      },
      act: (CategoryBloc bloc) async => bloc.add(CategoriesRequested()),
      expect: <CategoryState>[Failed()],
    );

    blocTest(
      'Initial state is correct',
      build: () => categoryBloc,
      expect: <CategoryState>[],
    );

    blocTest(
      'should load items in response to a CategoriesRequested event',
      build: () => categoryBloc,
      act: (CategoryBloc bloc) async => bloc.add(CategoriesRequested()),
      expect: [
        isA<Success>(),
      ],
    );
  });
}
