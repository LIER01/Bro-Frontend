import 'package:bro/models/category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  CategoryState();

  @override
  List<Object> get props => [];
}

class Loading extends CategoryState {}

class Success extends CategoryState {
  final List<Category> categories;

  Success({required this.categories});

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'Success { categories: $categories }';
}

class Failed extends CategoryState {}
