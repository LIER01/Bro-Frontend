import 'package:equatable/equatable.dart';

abstract class CourseListEvent extends Equatable {
  CourseListEvent();

  @override
  List get props => [];
}

class CourseListRequested extends CourseListEvent {
  final String? preferredLanguageSlug;

  // Sets 'NO' to default if no preferredLanguageSlug is defined
  CourseListRequested({preferredLanguageSlug})
      : preferredLanguageSlug = preferredLanguageSlug ?? 'NO';

  @override

  // This defines the props you need to check to determine if the state has changed.
  List get props => [preferredLanguageSlug];
}
