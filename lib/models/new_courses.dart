import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class LangCourseList {
  LangCourseList({
    required this.langCourses,
  });

  final List<LangCourse> langCourses;

  factory LangCourseList.takeList(List<Map<String, dynamic>> list) {
    List<LangCourse> returnList = [];
    for (final Map<String, dynamic> item in list) {
      returnList.add(LangCourse.fromJson(item));
    }
    return LangCourseList(langCourses: returnList);
  }
}

class LangCourse {
  LangCourse({
    required this.id,
    required this.questions,
    required this.slides,
    required this.title,
    this.publisher,
    this.category,
    required this.isRecommended,
    this.courseGroup,
  });

  factory LangCourse.fromJson(Map<String, dynamic> jsonRes) {
    final questions = jsonRes['questions'] is List ? <Questions>[] : null;
    if (questions != null) {
      for (final dynamic item in jsonRes['questions']!) {
        if (item != null) {
          questions.add(Questions.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final slides = jsonRes['slides'] is List ? <Slides>[] : null;
    if (slides != null) {
      for (final dynamic item in jsonRes['slides']!) {
        if (item != null) {
          slides.add(Slides.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return LangCourse(
      id: asT<String>(jsonRes['id'])!,
      questions: questions!,
      slides: slides!,
      title: asT<String>(jsonRes['title'])!,
      publisher: jsonRes['publisher'] == null
          ? null
          : Publisher.fromJson(
              asT<Map<String, dynamic>>(jsonRes['publisher'])!),
      category: jsonRes['category'] == null
          ? null
          : Category.fromJson(asT<Map<String, dynamic>>(jsonRes['category'])!),
      isRecommended: asT<bool>(jsonRes['is_recommended'])!,
      courseGroup: jsonRes['course_group'] == null
          ? null
          : Course_group.fromJson(
              asT<Map<String, dynamic>>(jsonRes['course_group'])!),
    );
  }

  final String id;
  final List<Questions> questions;
  final List<Slides> slides;
  final String title;
  final Publisher? publisher;
  final Category? category;
  final bool isRecommended;
  final Course_group? courseGroup;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'questions': questions,
        'slides': slides,
        'title': title,
        'publisher': publisher,
        'category': category,
        'is_recommended': isRecommended,
        'course_group': courseGroup,
      };

  LangCourse clone() => LangCourse.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Questions {
  Questions({
    required this.id,
  });

  factory Questions.fromJson(Map<String, dynamic> jsonRes) => Questions(
        id: asT<String>(jsonRes['id'])!,
      );

  final String id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
      };

  Questions clone() => Questions.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Slides {
  Slides({
    required this.id,
  });

  factory Slides.fromJson(Map<String, dynamic> jsonRes) => Slides(
        id: asT<String>(jsonRes['id'])!,
      );

  final String id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
      };

  Slides clone() =>
      Slides.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Publisher {
  Publisher({
    required this.name,
    required this.avatar,
  });

  factory Publisher.fromJson(Map<String, dynamic> jsonRes) => Publisher(
        name: asT<String>(jsonRes['name'])!,
        avatar: Avatar.fromJson(asT<Map<String, dynamic>>(jsonRes['avatar'])!),
      );

  final String name;
  final Avatar avatar;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'avatar': avatar,
      };

  Publisher clone() => Publisher.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Avatar {
  Avatar({
    required this.url,
  });

  factory Avatar.fromJson(Map<String, dynamic> jsonRes) => Avatar(
        url: asT<String>(jsonRes['url'])!,
      );

  final String url;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
      };

  Avatar clone() =>
      Avatar.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Category {
  Category({
    required this.coverPhoto,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> jsonRes) => Category(
        coverPhoto: Cover_photo.fromJson(
            asT<Map<String, dynamic>>(jsonRes['cover_photo'])!),
        categoryName: asT<String>(jsonRes['category_name'])!,
      );

  final Cover_photo coverPhoto;
  final String categoryName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cover_photo': coverPhoto,
        'category_name': categoryName,
      };

  Category clone() => Category.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Cover_photo {
  Cover_photo({
    required this.url,
  });

  factory Cover_photo.fromJson(Map<String, dynamic> jsonRes) => Cover_photo(
        url: asT<String>(jsonRes['url'])!,
      );

  final String url;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
      };

  Cover_photo clone() => Cover_photo.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Course_group {
  Course_group({
    required this.slug,
  });

  factory Course_group.fromJson(Map<String, dynamic> jsonRes) => Course_group(
        slug: asT<String>(jsonRes['slug'])!,
      );

  final String slug;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'slug': slug,
      };

  Course_group clone() => Course_group.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
