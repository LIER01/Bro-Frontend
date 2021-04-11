import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent();

  @override
  List get props => [];
}

class HomeRequested extends HomeEvent {
  // final Home home;
  // final List<Course> recommendedCourses;
  // HomeRequested({this.home,this.recommendedCourses});
  // @override
  // // This defines the props you need to check to determine if the state has changed.
  // List get props => [home, recommendedCourses];
}
