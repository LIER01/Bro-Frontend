import "package:equatable/equatable.dart";

abstract class CourseEvents extends Equatable {
  CourseEvents();

  @override
  List<Object> get props => null;
}

class FetchCourseData extends CourseEvents {
  final String query;
  final Map<String, dynamic> variables;

  FetchCourseData(this.query, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}
