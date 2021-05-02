import 'dart:developer';

import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/data/category_repository.dart';
// We set "category" as cat, due to that "Category" is a protected term in Flutter.
import 'package:bro/models/category.dart' as cat;
import 'package:flutter_bloc/flutter_bloc.dart';

// The categoryBloc retrieves the categories from the database, deserialzes the data into Models and returns them to the
// categoryview. It will always return the categories in norwegian.
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository repository;

  CategoryBloc({required this.repository}) : super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoriesRequested) {
      try {
        final result = await repository.getCategories();
        // There should always be available categories, but if server responds with
        // no categories, then we handle that outcome by passing a state of "Failed"
        final categories =
            result.data!['categories'] is List ? <cat.Category>[] : null;
        if (categories != null) {
          for (final item in result.data!['categories']) {
            if (item != null) {
              categories.add(cat.Category.fromJson(item));
            }
          }
          yield CategorySuccess(categories: categories);
          return;
        }

        yield CategoryFailed();
        return;
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield CategoryFailed();
      }
    }
  }
}
