import 'dart:html';

import "package:equatable/equatable.dart";

abstract class CourseStates extends Equatable {
  CourseStates();

  @override
  List<Object> get props => null;
}

class Loading extends CourseStates {
  Loading() : super();
}

class Success extends CourseStates {
  final dynamic data;

  Success(this.data) : super();

  @override
  List<Object> get props => data;
}

class Failed extends CourseStates {
  final dynamic error;

  Failed(this.error) : super();

  @override
  List<Object> get props => error;
}
