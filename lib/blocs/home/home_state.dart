import 'package:bro/models/course.dart';
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
  final List<Course> courses;
  final Home introduction;
  final bool hasReachedMax;

  Success(
      {@required this.courses,
      @required this.hasReachedMax,
      @required this.introduction})
      : assert(introduction.header != null &&
            courses != null &&
            hasReachedMax != null);

  Success copyWith({
    List<Course> courses,
    Map<String, dynamic> introduction,
    bool hasReachedMax,
  }) {
    return Success(
        courses: courses ?? this.courses,
        introduction: introduction ?? this.introduction,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [introduction, courses, hasReachedMax];

  @override
  String toString() =>
      'Success { introduction: $introduction, courses: $courses, hasReachedMax: $hasReachedMax }';
}

class Failed extends HomeState {}
