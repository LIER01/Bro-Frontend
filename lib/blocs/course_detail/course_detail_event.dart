import 'package:bro/models/course.dart';
import 'package:equatable/equatable.dart';

abstract class CourseDetailEvent extends Equatable {
  CourseDetailEvent();

  @override
  List get props => [];
}

class CourseDetailRequested extends CourseDetailEvent {
  final String? courseGroupSlug;
  final Course? course;
  final bool isQuiz;
  final bool isAnswer;
  final int? answerId;
  CourseDetailRequested({
    this.course,
    this.courseGroupSlug,
    required this.isQuiz,
    required this.isAnswer,
    this.answerId,
    // Either you need to provide a course_id or you need to provide a course
  })  : assert(courseGroupSlug != null || course != null),
        // If "isAnswer", you also need to provide an answerId
        assert(isAnswer == false || (isAnswer == true && answerId != null));

  @override

  // This defines the props you need to check to determine if the state has changed.
  List get props => [isQuiz, isAnswer, answerId];
}
