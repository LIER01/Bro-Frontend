import 'package:bro/models/home.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState();

  @override
  List<Object> get props => [];
}

class Initial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Home home;
  HomeSuccess({required this.home});

  HomeSuccess copyWith({
    required Home home,
  }) {
    return HomeSuccess(
      home: home,
    );
  }

  @override
  List<Object> get props => [home];

  @override
  String toString() => 'HomeSuccess {home: $home}';
}

class HomeFailed extends HomeState {}
