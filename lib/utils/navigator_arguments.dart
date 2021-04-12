import 'package:meta/meta.dart';

class CourseDetailArguments {
  final int courseId;
  CourseDetailArguments({@required this.courseId}) : assert(courseId != null);
}

class ResourceDetailArguments {
  final String lang;
  final String group;

  ResourceDetailArguments({@required this.lang, @required this.group})
      : assert(lang != null),
        assert(group != null);
}
