import 'package:equatable/equatable.dart';

abstract class PreferredLanguageEvent extends Equatable {
  PreferredLanguageEvent();

  @override
  List get props => [];
}

class MutatePreferredLang extends PreferredLanguageEvent {
  final String preferredLang;
  MutatePreferredLang({preferredLang}) : preferredLang = preferredLang ?? 'NO';

  @override
  // This defines the props you need to check to determine if the state has changed.
  List get props => [preferredLang];
}

class PreferredLanguageRequested extends PreferredLanguageEvent {
  PreferredLanguageRequested();
}
