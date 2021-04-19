import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/models/new_course.dart';

class WrongEvent extends CourseDetailEvent {
  final int? courseId;
  final Courses? course;
  final bool isQuiz;
  final bool isAnswer;
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
