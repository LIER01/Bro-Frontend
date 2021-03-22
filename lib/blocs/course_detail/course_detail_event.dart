import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:bro/models/course.dart';

abstract class CourseDetailEvent extends Equatable {
  CourseDetailEvent();

  @override
  List get props => [];
}

class CourseDetailRequested extends CourseDetailEvent {
  int course_id;
  Course course;
  bool is_quiz;
  bool is_answer;
  int answer_id = 0;
  CourseDetailRequested({
    this.course,
    this.course_id,
    this.is_quiz,
    this.is_answer,
    this.answer_id,
  }) : assert(course_id != null || course != null);

  List get props => [is_quiz, is_answer, answer_id];
}
