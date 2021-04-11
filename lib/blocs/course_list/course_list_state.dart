import 'package:bro/models/reduced_course.dart';
import 'package:bro/models/new_courses.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CourseListState extends Equatable {
  CourseListState();

  @override
  List<Object> get props => [];
}

class Initial extends CourseListState {}

class Loading extends CourseListState {}

class Success extends CourseListState {
  final List<LangCourse> courses;
  final bool hasReachedMax;

  Success({required this.courses, required this.hasReachedMax});

  Success copyWith({
    required List<LangCourse> courses,
    bool? hasReachedMax,
  }) {
    return Success(
        courses: courses, hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [courses, hasReachedMax];

  @override
  String toString() =>
      'Success { courses: $courses, hasReachedMax: $hasReachedMax }';
}

class Failed extends CourseListState {}
