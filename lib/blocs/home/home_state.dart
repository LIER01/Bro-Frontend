import 'package:bro/models/reduced_course.dart';
import 'package:bro/models/home.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState();

  @override
  List<Object> get props => [];
}

class Initial extends HomeState {}

class Loading extends HomeState {}

class Success extends HomeState {
  final List<ReducedCourse> courses;
  final Home home;
  final bool hasReachedMax;

  Success(
<<<<<<< HEAD
      {required this.courses, required this.hasReachedMax, required this.home});
=======
      {@required this.courses,
      @required this.hasReachedMax,
      @required this.home})
      : assert(home != null && courses != null && hasReachedMax != null);

>>>>>>> 47949703b16a35503390214e8313928c7cb75293

  Success copyWith({
    List<ReducedCourse>? courses,
    Map<String, dynamic>? home,
    bool? hasReachedMax,
  }) {
    return Success(
        courses: courses ?? this.courses,
        home: home as Home? ?? this.home,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [home, courses, hasReachedMax];

  @override
  String toString() =>
      'Success { courses: $courses, hasReachedMax: $hasReachedMax, home: $home }';
}

class Failed extends HomeState {}
