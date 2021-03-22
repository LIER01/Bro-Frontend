import 'package:bro/models/course.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CourseDetailState extends Equatable {
  CourseDetailState();

  @override
  List<Object> get props => [];
}

class Loading extends CourseDetailState {}

class CourseState extends CourseDetailState {
  Course course;
  bool is_quiz;
  bool is_answer;
  int answer_id;

  CourseState({this.course, this.is_quiz, this.is_answer, this.answer_id})
      : assert(course != null);

  @override
  List<Object> get props => [course];
}

class QuizState extends CourseDetailState {
  bool is_answer;
  int answer_id;
  QuizState({@required this.is_answer, this.answer_id});
}

class Failed extends CourseDetailState {}
