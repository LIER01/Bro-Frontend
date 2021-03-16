import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CourseStates extends Equatable {
  CourseStates();

  @override
  List<Object> get props => [];
}

class Initial extends CourseStates {}

class Loading extends CourseStates {}

class Success extends CourseStates {
  final List<Object> courses;

  Success({@required this.courses}) : assert(courses != null);

  @override
  List<Object> get props => [courses];
}

class Failed extends CourseStates {}
