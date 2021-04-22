import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent();

  @override
  List get props => [];
}

class HomeRequested extends HomeEvent {
  // Sets "NO" to default if no preferredLanguageSlug is defined
  HomeRequested();

  @override
  // This defines the props you need to check to determine if the state has changed.
  List get props => [];
}
