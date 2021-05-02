import 'package:bro/models/category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<Category> categories;

  CategorySuccess({required this.categories});

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'Success { categories: $categories }';
}

class CategoryFailed extends CategoryState {}
