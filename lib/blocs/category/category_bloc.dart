import 'dart:developer';

import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/data/category_repository.dart';
import 'package:bro/models/category.dart' as Cat;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository repository;

  CategoryBloc({required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoriesRequested) {
      try {
        final result = await repository.getCategories();
        final categories =
            result.data!['categories'] is List ? <Cat.Category>[] : null;

        if (categories != null) {
          for (final dynamic item in result.data!['categories']) {
            if (item != null) {
              categories.add(Cat.Category.fromJson(item));
            }
            yield Success(categories: categories);
            return;
          }
        }

        yield Failed();
        return;
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    }
  }
}
