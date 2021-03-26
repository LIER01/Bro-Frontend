import 'package:bro/models/category.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

abstract class CategoryState extends Equatable {
  CategoryState();

  @override
  List<Object> get props => [];
}

class Loading extends CategoryState {}

class Success extends CategoryState {
  final List<Category> categories;

  Success({@required this.categories}) : assert(categories != null);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'Success { categories: $categories }';
}

class Failed extends CategoryState {
  /*final List<dynamic> errors;

  Failed({@required this.errors}) : assert(errors != null);

  @override
  List<dynamic> get props => errors;

  @override
  String toString() => 'Failed( errors: $errors )';*/
}
