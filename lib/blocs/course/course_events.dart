import "package:equatable/equatable.dart";

abstract class CourseEvents extends Equatable {
  CourseEvents();

  @override
  List<Object> get props => [];
}

class CourseRequested extends CourseEvents {}
