import 'package:bro/models/course.dart';
import 'package:equatable/equatable.dart';

abstract class CourseDetailState extends Equatable {
  CourseDetailState();

  @override
  List<Object> get props => [];
}

class CourseDetailLoading extends CourseDetailState {}

class InitialDetailList extends CourseDetailState {}

/// Returns a CourseState. Takes in a Course, isQuiz and isAnswer. If isAnswer is set to true, then answerId needs to be non-null.
/// The State listens to course, isQuiz and isAnswer for changes to the state.
class CourseDetailSuccess extends CourseDetailState {
  final Course course;
  final bool isQuiz;
  final bool isAnswer;
  final int? answerId;

  CourseDetailSuccess(
      {required this.course,
      required this.isQuiz,
      required this.isAnswer,
      this.answerId})
      // Checks that if isAnswer is True, that answerId is set.
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
