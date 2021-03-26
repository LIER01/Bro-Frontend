import 'package:equatable/equatable.dart';
import 'package:bro/models/course.dart';

abstract class CourseDetailEvent extends Equatable {
  CourseDetailEvent();

  @override
  List get props => [];
}

class CourseDetailRequested extends CourseDetailEvent {
  final int courseId;
  final Course course;
  final bool isQuiz;
  final bool isAnswer;
  final int answerId;
  CourseDetailRequested({
    this.course,
    this.courseId,
    this.isQuiz,
    this.isAnswer,
    this.answerId,
  }) : assert(courseId != null || course != null);

  @override
  List get props => [isQuiz, isAnswer, answerId];
}
