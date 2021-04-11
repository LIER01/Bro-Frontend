import 'package:bro/models/new_courses.dart';
import 'package:bro/models/reduced_course.dart';
import 'package:bro/models/home.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeState extends Equatable {
  HomeState();

  @override
  List<Object> get props => [];
}

class Initial extends HomeState {}

class Loading extends HomeState {}

class Success extends HomeState {
  final List<LangCourse> courses;
  final Home home;
  final bool hasReachedMax;

  Success(
      {required this.courses, required this.hasReachedMax, required this.home})
      : assert(home.header != null && courses != null && hasReachedMax != null);

  Success copyWith({
    List<LangCourse>? courses,
    Map<String, dynamic>? home,
    bool? hasReachedMax,
  }) {
    return Success(
        courses: courses ?? this.courses,
        home: home as Home? ?? this.home,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [home, courses, hasReachedMax];

  @override
  String toString() =>
      'Success { home: $home, courses: $courses, hasReachedMax: $hasReachedMax }';
}

class Failed extends HomeState {}
