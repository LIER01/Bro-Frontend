import 'package:equatable/equatable.dart';

abstract class PreferredLanguageEvent extends Equatable {
  PreferredLanguageEvent();

  @override
  List get props => [];
}

class MutatePreferredLanguage extends PreferredLanguageEvent {
  final String preferredLanguage;
  MutatePreferredLanguage({preferredLanguage})
      : preferredLanguage = preferredLanguage ?? 'NO';

  @override
  // This defines the props you need to check to determine if the state has changed.
  List get props => [preferredLanguage];
}

class PreferredLanguageRequested extends PreferredLanguageEvent {
  PreferredLanguageRequested();
}
