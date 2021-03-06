import 'package:equatable/equatable.dart';

abstract class CourseListEvent extends Equatable {
  CourseListEvent();

  @override
  List get props => [];
}

class CourseListRequested extends CourseListEvent {
  // Sets 'NO' to default if no preferredLanguageSlug is defined
  CourseListRequested();

  @override
  // This defines the props you need to check to determine if the state has changed.
  List get props => [];
}

class RecommendedCoursesRequested extends CourseListEvent {
  // Sets 'NO' to default if no preferredLanguageSlug is defined
  RecommendedCoursesRequested();
}

class CourseListRefresh extends CourseListEvent {
  CourseListRefresh();

  @override
  List get props => [];
}
