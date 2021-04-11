import 'package:equatable/equatable.dart';

abstract class CourseListEvent extends Equatable {
  CourseListEvent();

  @override
  List get props => [];
}

class CourseListRequested extends CourseListEvent {}
