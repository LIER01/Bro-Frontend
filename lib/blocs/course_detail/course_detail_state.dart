import 'package:bro/models/course.dart';
import 'package:bro/models/new_course.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CourseDetailState extends Equatable {
  CourseDetailState();

  @override
  List<Object> get props => [];
}

class Loading extends CourseDetailState {}

class CourseState extends CourseDetailState {
  final Courses course;
  final bool isQuiz;
  final bool isAnswer;
  final int? answerId;

  CourseState(
      {required this.course,
      required this.isQuiz,
      required this.isAnswer,
      this.answerId})
      : assert(!isAnswer || (isAnswer && answerId != null));

  @override
  List<Object> get props => [course, isQuiz, isAnswer];
}

class Failed extends CourseDetailState {
  final String err;
  Failed({required this.err});

  @override
  List<Object> get props => [err];
}
