import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List get props => [];
}

class LanguagesRequested extends SettingsEvent {
  final String preferredLanguageSlug;

  // Sets 'NO' to default if no preferredLanguageSlug is defined
  LanguagesRequested({preferredLanguageSlug})
      : preferredLanguageSlug = preferredLanguageSlug ?? 'NO';

  @override
  // This defines the props you need to check to determine if the state has changed.
  List get props => [preferredLanguageSlug];
}

class MutateCurrentLanguage extends SettingsEvent {
  final String? lang;
  MutateCurrentLanguage({required this.lang});
}

class CurrentLanguageRequested extends SettingsEvent {
  CurrentLanguageRequested();
}
