import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent();

  @override
  List get props => [];
}

class HomeRequested extends HomeEvent {}
