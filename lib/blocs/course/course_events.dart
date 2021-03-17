import "package:equatable/equatable.dart";
import 'package:flutter/cupertino.dart';

abstract class CourseEvents extends Equatable {
  CourseEvents();

  @override
  List get props => [];
}

class CoursesRequested extends CourseEvents {}

class CourseRequested extends CourseEvents {
  final int course_id;
  CourseRequested({@required this.course_id}) : assert(course_id != null);
}

class QuizSwitchRequested extends CourseEvents {}
