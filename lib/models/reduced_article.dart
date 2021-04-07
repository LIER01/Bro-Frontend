class ReducedArticle {
  ReducedArticle({
    required this.id,
    required this.localizedArticles,
    this.publisher,
    this.category,
    required this.isRecommended,
  });

  final int id;
  final List<ReducedLocalizedArticles> localizedArticles;
  final Publisher? publisher;
  final Category? category;
  final bool isRecommended;

  ReducedArticle.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        localizedArticles = List<ReducedLocalizedArticles>.from(
            json['localized_articles']
                .map((model) => ReducedLocalizedArticles.fromJson(model))),
        publisher = json['publisher'] == null
            ? null
            : Publisher.fromJson(json['publisher']),
        category = json['category'] == null
            ? null
            : Category.fromJson(json['category']),
        isRecommended = json['is_recommended'] as bool;
}

class ReducedLocalizedArticles {
  ReducedLocalizedArticles({
    required this.id,
    required this.title,
    this.language,
  });

  final int id;
  final String title;
  final Language? language;

  ReducedLocalizedArticles.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        title = json['title'],
        language = json['language'] == null
            ? null
            : Language.fromJson(json['language']);
}

class Language {
  Language({
    required this.name,
    required this.slug,
  });

  final String name;
  final String slug;

  Language.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        slug = json['slug'];
}

class Publisher {
  Publisher({
    required this.name,
    required this.avatar,
  });

  Publisher.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        avatar = Avatar.fromJson(json['avatar']);

  final String name;
  final Avatar avatar;
}

class Avatar {
  Avatar({
    required this.url,
  });

  final String url;

  Avatar.fromJson(Map<String, dynamic> json) : url = json['url'];
}

class Category {
  Category({
    required this.name,
  });

  final String name;

  Category.fromJson(Map<String, dynamic> json) : name = json['name'];
}
