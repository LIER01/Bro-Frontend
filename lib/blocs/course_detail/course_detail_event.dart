import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CourseDetailEvent extends Equatable {
  CourseDetailEvent();

  @override
  List get props => [];
}

class CourseDetailRequested extends CourseDetailEvent {
  final int course_id;
  bool is_quiz = false;
  bool is_answer = false;
  int answer_id = null;
  CourseDetailRequested({
    this.course_id,
    this.is_quiz,
    this.is_answer,
    this.answer_id,
  }) : assert(course_id != null);
}

class QuizRequested extends CourseDetailEvent {
  bool is_answer;
  int answer_id;
  QuizRequested({@required this.is_answer, this.answer_id})
      : assert(is_answer != null);
}
