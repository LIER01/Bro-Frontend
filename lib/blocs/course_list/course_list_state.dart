import 'package:bro/models/courses.dart';
import 'package:equatable/equatable.dart';

abstract class CourseListState extends Equatable {
  CourseListState();

  @override
  List<Object> get props => [];
}

class InitialCourseList extends CourseListState {}

class Loading extends CourseListState {}

class CourseListSuccess extends CourseListState {
  final List<LangCourse> courses;
  final bool hasReachedMax;

  CourseListSuccess({required this.courses, required this.hasReachedMax});

  CourseListSuccess copyWith({
    required List<LangCourse> courses,
    bool? hasReachedMax,
  }) {
    return CourseListSuccess(
        courses: courses, hasReachedMax: hasReachedMax ?? false);
  }

  @override
  List<Object> get props => [courses, hasReachedMax];

  @override
  String toString() =>
      'Success { courses: ${courses}, hasReachedMax: $hasReachedMax }';
}

class CourseListFailed extends CourseListState {}
