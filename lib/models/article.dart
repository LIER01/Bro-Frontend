class Article {
  Article({
    required this.id,
    required this.localizedArticles,
    this.publisher,
    this.category,
    required this.isRecommended,
  });

  final int id;
  final List<LocalizedArticles> localizedArticles;
  final Publisher? publisher;
  final Category? category;
  final bool isRecommended;

  Article.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        localizedArticles = List<LocalizedArticles>.from(
            json['localized_articles']
                .map((model) => LocalizedArticles.fromJson(model))),
        publisher = json['publisher'] == null
            ? null
            : Publisher.fromJson(json['publisher']),
        category = json['category'] == null
            ? null
            : Category.fromJson(json['category']),
        isRecommended = json['is_recommended'] as bool;
}

class LocalizedArticles {
  LocalizedArticles({
    required this.id,
    required this.title,
    required this.description,
    this.resources,
    this.documents,
    this.language,
  });

  final int id;
  final String title;
  final String description;
  final List<Resource>? resources;
  final List<Document>? documents;
  final Language? language;

  LocalizedArticles.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        title = json['title'],
        description = json['description'],
        resources = json['resources'] == null
            ? null
            : List<Resource>.from(
                json['resources'].map((model) => Resource.fromJson(model))),
        documents = json['documents'] == null
            ? null
            : List<Document>.from(
                json['documents'].map((model) => Document.fromJson(model))),
        language = json['language'] == null
            ? null
            : Language.fromJson(json['language']);
}

class Resource {
  Resource({
    required this.title,
    required this.url,
    required this.description,
    required this.sourceName,
  });

  final String title;
  final String url;
  final String description;
  final String sourceName;

  Resource.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        url = json['url'],
        description = json['description'],
        sourceName = json['source_name'];
}

class Document {
  Document({required this.name, required this.documentFile});

  final String name;
  final DocumentFile documentFile;

  Document.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        documentFile = DocumentFile.fromJson(json['document']);
}

class DocumentFile {
  DocumentFile({
    required this.url,
  });

  final String url;

  DocumentFile.fromJson(Map<String, dynamic> json) : url = json['url'];
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
