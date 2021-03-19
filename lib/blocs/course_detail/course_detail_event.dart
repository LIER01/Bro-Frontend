import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CourseDetailEvent extends Equatable {
  CourseDetailEvent();

  @override
  List get props => [];
}

class CourseDetailRequested extends CourseDetailEvent {
  final int course_id;
  CourseDetailRequested({@required this.course_id}) : assert(course_id != null);
}

class QuizRequested extends CourseDetailEvent {}
