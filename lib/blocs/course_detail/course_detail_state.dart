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
  final Course course;
  bool isQuiz;
  bool isAnswer;
  int answerId;

  CourseState({this.course, this.isQuiz, this.isAnswer, this.answerId})
      : assert(course != null);

  @override
  List<Object> get props => [course, isQuiz, isAnswer];
}

class Failed extends CourseDetailState {}
