class CourseDetailArguments {
  final String courseGroup;
  CourseDetailArguments({required this.courseGroup});
}

class ResourceListArguments {
  final String category;
  ResourceListArguments({required this.category});
}

class ResourceDetailArguments {
  final String lang;
  final String group;

  ResourceDetailArguments({required this.lang, required this.group});
}

class ResourceDetailWebViewArguments {
  final String url;

  ResourceDetailWebViewArguments({required this.url});
}
