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

  CourseState({@required this.course}) : assert(course != null);

  @override
  List<Object> get props => [course];
}

class QuizState extends CourseDetailState {
  QuizState();
}

class Failed extends CourseDetailState {}
