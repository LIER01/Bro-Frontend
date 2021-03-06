import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

// This course is an instance of a Course, but having a reduced number of values to decrease querysize.
class ReducedCourse {
  ReducedCourse({
    required this.questions,
    required this.slides,
    required this.title,
    required this.description,
    this.publisher,
    this.category,
    required this.isRecommended,
    this.courseGroup,
  });

  static List<ReducedCourse> generateList(List<Map<String, dynamic>> list) {
    var returnList = <ReducedCourse>[];
    for (final item in list) {
      if (item['course_group'] != null && item['publisher'] != null) {
        returnList.add(ReducedCourse.fromJson(item));
      }
    }
    return returnList;
  }

  factory ReducedCourse.fromJson(Map<String, dynamic> jsonRes) {
    final questions = jsonRes['questions'] is List ? <ReducedQuestion>[] : null;
    if (questions != null) {
      for (final dynamic item in jsonRes['questions']!) {
        if (item != null) {
          questions
              .add(ReducedQuestion.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final slides = jsonRes['slides'] is List ? <ReducedSlide>[] : null;
    if (slides != null) {
      for (final dynamic item in jsonRes['slides']!) {
        if (item != null) {
          slides.add(ReducedSlide.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ReducedCourse(
      questions: questions!,
      slides: slides!,
      title: asT<String>(jsonRes['title'])!,
      description: asT<String>(jsonRes['description'])!,
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

  final List<ReducedQuestion> questions;
  final List<ReducedSlide> slides;
  final String title;
  final String description;
  final Publisher? publisher;
  final Category? category;
  final bool isRecommended;
  final Course_group? courseGroup;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'questions': questions,
        'slides': slides,
        'title': title,
        'description': description,
        'publisher': publisher,
        'category': category,
        'is_recommended': isRecommended,
        'course_group': courseGroup,
      };

  ReducedCourse clone() => ReducedCourse.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class ReducedQuestion {
  ReducedQuestion({
    required this.id,
  });

  factory ReducedQuestion.fromJson(Map<String, dynamic> jsonRes) =>
      ReducedQuestion(
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

  ReducedQuestion clone() => ReducedQuestion.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class ReducedSlide {
  ReducedSlide({
    required this.id,
  });

  factory ReducedSlide.fromJson(Map<String, dynamic> jsonRes) => ReducedSlide(
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

  ReducedSlide clone() => ReducedSlide.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
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
