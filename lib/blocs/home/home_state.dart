import 'package:bro/models/courses.dart';
import 'package:bro/models/home.dart';
import 'package:equatable/equatable.dart';

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

  Success({required this.courses, required this.home});

  Success copyWith({
    required List<LangCourse> courses,
    Map<String, dynamic>? home,
  }) {
    return Success(
      courses: courses,
      home: home as Home? ?? this.home,
    );
  }

  @override
  List<Object> get props => [home, courses];

  @override
  String toString() =>
      'Success { reccourses: ${courses[0].description}, home: $home }';
}

class Failed extends HomeState {}
