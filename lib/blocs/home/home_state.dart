import 'package:bro/models/courses.dart';
import 'package:bro/models/home.dart';
import 'package:bro/models/resource.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState();

  @override
  List<Object> get props => [];
}

/// TODO
/// Change Home to the correct type and add Resources
class Initial extends HomeState {}

class Loading extends HomeState {}

class Success extends HomeState {
  final List<LangCourse> courses;
  final List<Resources> resources;
  final Home home;
  Success({required this.courses, required this.home, required this.resources});

  Success copyWith({
    required List<LangCourse> courses,
    required List<Resources> resources,
    required Home home,
  }) {
    return Success(
      courses: courses,
      resources: resources,
      home: home,
    );
  }

  @override
  List<Object> get props => [home, courses, resources];

  @override
  String toString() =>
      'Success { courses: ${courses}, home: $home, resources: $resources}';
}

class Failed extends HomeState {}
