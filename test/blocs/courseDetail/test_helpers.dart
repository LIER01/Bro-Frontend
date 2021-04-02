import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/course.dart';
import 'package:meta/meta.dart';

class WrongEvent extends CourseDetailEvent {
  @override
  final int? courseId;
  @override
  final Course? course;
  @override
  final bool isQuiz;
  @override
  final bool isAnswer;
  @override
  final int? answerId;
  WrongEvent({
    this.course,
    this.courseId,
    required this.isQuiz,
    required this.isAnswer,
    this.answerId,
    // Either you need to provide a course_id or you need to provide a course
  })  : assert(courseId != null || course != null),
        // If "isAnswer", you also need to provide an answerId
        assert(!isAnswer || (isAnswer && answerId != null));

  @override

  // This defines the props you need to check to determine if the state has changed.
  List get props => [isQuiz, isAnswer, answerId];
}
