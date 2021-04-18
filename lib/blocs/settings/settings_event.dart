import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List get props => [];
}

class LanguagesRequested extends SettingsEvent {}
