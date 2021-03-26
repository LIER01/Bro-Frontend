import 'package:equatable/equatable.dart';
import 'package:bro/models/course.dart';

abstract class CourseDetailEvent extends Equatable {
  CourseDetailEvent();

  @override
  List get props => [];
}

class CourseDetailRequested extends CourseDetailEvent {
  int courseId;
  Course course;
  bool isQuiz;
  bool isAnswer;
  int answerId = 0;
  CourseDetailRequested({
    this.course,
    this.courseId,
    this.isQuiz,
    this.isAnswer,
    this.answerId,
  }) : assert(courseId != null || course != null);

  List get props => [isQuiz, isAnswer, answerId];
}
