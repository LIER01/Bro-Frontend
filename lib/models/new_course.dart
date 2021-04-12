import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Courses {
  Courses({
    required this.questions,
    required this.slides,
    required this.title,
    required this.description,
    this.language,
    this.publisher,
    this.category,
    required this.isRecommended,
    this.courseGroup,
  });

  factory Courses.fromJson(Map<String, dynamic> jsonRes) {
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
    return Courses(
      questions: questions!,
      slides: slides!,
      title: asT<String>(jsonRes['title'])!,
      description: asT<String>(jsonRes['description'])!,
      language: jsonRes['language'] == null
          ? null
          : Language.fromJson(asT<Map<String, dynamic>>(jsonRes['language'])!),
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

  final List<Questions> questions;
  final List<Slides> slides;
  final String title;
  final String description;
  final Language? language;
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
        'language': language,
        'publisher': publisher,
        'category': category,
        'is_recommended': isRecommended,
        'course_group': courseGroup,
      };

  Courses clone() => Courses.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Questions {
  Questions({
    required this.question,
    required this.alternatives,
    required this.clarification,
  });

  factory Questions.fromJson(Map<String, dynamic> jsonRes) {
    final alternatives =
        jsonRes['alternatives'] is List ? <Alternatives>[] : null;
    if (alternatives != null) {
      for (final dynamic item in jsonRes['alternatives']!) {
        if (item != null) {
          alternatives
              .add(Alternatives.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return Questions(
      question: asT<String>(jsonRes['question'])!,
      alternatives: alternatives!,
      clarification: asT<String>(jsonRes['clarification'])!,
    );
  }

  final String question;
  final List<Alternatives> alternatives;
  final String clarification;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'question': question,
        'alternatives': alternatives,
        'clarification': clarification,
      };

  Questions clone() => Questions.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Alternatives {
  Alternatives({
    required this.alternativeText,
    this.image,
    required this.isCorrect,
  });

  factory Alternatives.fromJson(Map<String, dynamic> jsonRes) => Alternatives(
        alternativeText: asT<String>(jsonRes['alternative_text'])!,
        image: asT<Object?>(jsonRes['image']),
        isCorrect: asT<bool>(jsonRes['is_correct'])!,
      );

  final String alternativeText;
  final Object? image;
  final bool isCorrect;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'alternative_text': alternativeText,
        'image': image,
        'is_correct': isCorrect,
      };

  Alternatives clone() => Alternatives.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Slides {
  Slides({
    required this.title,
    required this.description,
    this.media,
  });

  factory Slides.fromJson(Map<String, dynamic> jsonRes) => Slides(
        title: asT<String>(jsonRes['title'])!,
        description: asT<String>(jsonRes['description'])!,
        media: jsonRes['media'] == null
            ? null
            : Media.fromJson(asT<Map<String, dynamic>>(jsonRes['media'])!),
      );

  final String title;
  final String description;
  final Media? media;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
        'media': media,
      };

  Slides clone() =>
      Slides.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Media {
  Media({
    required this.url,
  });

  factory Media.fromJson(Map<String, dynamic> jsonRes) => Media(
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

  Media clone() =>
      Media.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Language {
  Language({
    required this.languageFullName,
    required this.slug,
  });

  factory Language.fromJson(Map<String, dynamic> jsonRes) => Language(
        languageFullName: asT<String>(jsonRes['language_full_name'])!,
        slug: asT<String>(jsonRes['slug'])!,
      );

  final String languageFullName;
  final String slug;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'language_full_name': languageFullName,
        'slug': slug,
      };

  Language clone() => Language.fromJson(
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
    required this.name,
    required this.slug,
  });

  factory Course_group.fromJson(Map<String, dynamic> jsonRes) => Course_group(
        name: asT<String>(jsonRes['name'])!,
        slug: asT<String>(jsonRes['slug'])!,
      );

  final String name;
  final String slug;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'slug': slug,
      };

  Course_group clone() => Course_group.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
