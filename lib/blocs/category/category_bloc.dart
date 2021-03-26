import 'dart:developer';

import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/data/category_repository.dart';
import 'package:bro/models/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository repository;

  CategoryBloc({@required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoriesRequested) {
      try {
        final result = await repository.getCategories();
        final categories = result.data['categories'] as List<dynamic>;

        final listOfCategories = categories
            .map(
              (dynamic e) => Category(
                name: e['name'],
                cover_photo: env['API_URL'] + e['cover_photo']['url'],
              ),
            )
            .toList();

        yield Success(categories: listOfCategories);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    }
  }
}
