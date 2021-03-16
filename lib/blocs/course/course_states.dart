import 'package:bro/models/course.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CourseStates extends Equatable {
  //CourseStates([List props = const []]) : super(props);

  @override
  List get props => [];
}

class Initial extends CourseStates {}

class Loading extends CourseStates {}

class Success extends CourseStates {
  final List<Course> courses;

  Success({@required this.courses}) : assert(courses != null);

  @override
  List<Course> get props => courses;
}

class Failed extends CourseStates {}

class Course_Success extends CourseStates {
  final Course course;

  Course_Success({@required this.course}) : assert(course != null);
}

class Switch_to_Quiz extends CourseStates {
  Switch_to_Quiz();
}
