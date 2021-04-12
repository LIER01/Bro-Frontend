import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ResourceDetailEvent extends Equatable {
  ResourceDetailEvent();

  @override
  List get props => [];
}

class ResourceDetailRequested extends ResourceDetailEvent {
  final String lang;
  final String group;

  ResourceDetailRequested({@required this.lang, @required this.group})
      : assert(lang != null),
        assert(group != null);

  @override
  List get props => [lang, group];
}
