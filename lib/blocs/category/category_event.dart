import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  CategoryEvent();

  @override
  List get props => [];
}

class CategoriesRequested extends CategoryEvent {}
