class CourseDetailArguments {
  final String courseGroup;
  CourseDetailArguments({required this.courseGroup});
}

class ResourceListArguments {
  final String category;
  final String category_id;
  ResourceListArguments({required this.category, required this.category_id});
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
