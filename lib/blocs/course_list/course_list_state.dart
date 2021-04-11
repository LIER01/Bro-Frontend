import 'package:bro/models/reduced_course.dart';
import 'package:equatable/equatable.dart';

abstract class CourseListState extends Equatable {
  CourseListState();

  @override
  List<Object> get props => [];
}

class Initial extends CourseListState {}

class Loading extends CourseListState {}

class Success extends CourseListState {
  final List<ReducedCourse> courses;
  final bool hasReachedMax;

  Success({required this.courses, required this.hasReachedMax});

  Success copyWith({
    List<ReducedCourse>? courses,
    bool? hasReachedMax,
  }) {
    return Success(
        courses: courses ?? this.courses,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [courses, hasReachedMax];

  @override
  String toString() =>
      'Success { courses: $courses, hasReachedMax: $hasReachedMax }';
}

class Failed extends CourseListState {}
