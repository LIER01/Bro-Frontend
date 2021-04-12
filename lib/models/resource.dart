import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Root {
  Root({
    required this.data,
  });

  factory Root.fromJson(Map<String, dynamic> jsonRes) => Root(
        data: Data.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])!),
      );

  Data data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
      };

  Root clone() =>
      Root.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Data {
  Data({
    required this.resources,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) {
    final List<Resources>? resources =
        jsonRes['resources'] is List ? <Resources>[] : null;
    if (resources != null) {
      for (final dynamic item in jsonRes['resources']!) {
        if (item != null) {
          resources.add(Resources.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return Data(
      resources: resources!,
    );
  }

  List<Resources> resources;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'resources': resources,
      };

  Data clone() =>
      Data.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Resources {
  Resources({
    required this.title,
    required this.coverPhoto,
    required this.description,
    this.language,
    this.resourceGroup,
    this.publisher,
    this.category,
    required this.isRecommended,
    required this.references,
    this.documents,
  });

  factory Resources.fromJson(Map<String, dynamic> jsonRes) {
    final List<References>? references =
        jsonRes['references'] is List ? <References>[] : null;
    if (references != null) {
      for (final dynamic item in jsonRes['references']!) {
        if (item != null) {
          references.add(References.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<Documents>? documents =
        jsonRes['documents'] is List ? <Documents>[] : null;
    if (documents != null) {
      for (final dynamic item in jsonRes['documents']!) {
        if (item != null) {
          documents.add(Documents.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return Resources(
      title: asT<String>(jsonRes['title'])!,
      coverPhoto: Cover_photo.fromJson(
          asT<Map<String, dynamic>>(jsonRes['cover_photo'])!),
      description: asT<String>(jsonRes['description'])!,
      language: jsonRes['language'] == null
          ? null
          : Language.fromJson(asT<Map<String, dynamic>>(jsonRes['language'])!),
      resourceGroup: jsonRes['resource_group'] == null
          ? null
          : Resource_group.fromJson(
              asT<Map<String, dynamic>>(jsonRes['resource_group'])!),
      publisher: jsonRes['publisher'] == null
          ? null
          : Publisher.fromJson(
              asT<Map<String, dynamic>>(jsonRes['publisher'])!),
      category: jsonRes['category'] == null
          ? null
          : Category.fromJson(asT<Map<String, dynamic>>(jsonRes['category'])!),
      isRecommended: asT<bool>(jsonRes['is_recommended'])!,
      references: references!,
      documents: documents,
    );
  }

  String title;
  Cover_photo coverPhoto;
  String description;
  Language? language;
  Resource_group? resourceGroup;
  Publisher? publisher;
  Category? category;
  bool isRecommended;
  List<References> references;
  List<Documents>? documents;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'cover_photo': coverPhoto,
        'description': description,
        'language': language,
        'resource_group': resourceGroup,
        'publisher': publisher,
        'category': category,
        'is_recommended': isRecommended,
        'references': references,
        'documents': documents,
      };

  Resources clone() => Resources.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Cover_photo {
  Cover_photo({
    required this.url,
  });

  factory Cover_photo.fromJson(Map<String, dynamic> jsonRes) => Cover_photo(
        url: asT<String>(jsonRes['url'])!,
      );

  String url;

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

class Language {
  Language({
    required this.slug,
  });

  factory Language.fromJson(Map<String, dynamic> jsonRes) => Language(
        slug: asT<String>(jsonRes['slug'])!,
      );

  String slug;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'slug': slug,
      };

  Language clone() => Language.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Resource_group {
  Resource_group({
    required this.slug,
  });

  factory Resource_group.fromJson(Map<String, dynamic> jsonRes) =>
      Resource_group(
        slug: asT<String>(jsonRes['slug'])!,
      );

  String slug;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'slug': slug,
      };

  Resource_group clone() => Resource_group.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Publisher {
  Publisher({
    required this.name,
  });

  factory Publisher.fromJson(Map<String, dynamic> jsonRes) => Publisher(
        name: asT<String>(jsonRes['name'])!,
      );

  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
      };

  Publisher clone() => Publisher.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Category {
  Category({
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> jsonRes) => Category(
        categoryName: asT<String>(jsonRes['category_name'])!,
      );

  String categoryName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'category_name': categoryName,
      };

  Category clone() => Category.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class References {
  References({
    required this.referenceTitle,
    required this.referenceDescription,
    required this.referenceUrl,
    required this.referenceButtonText,
  });

  factory References.fromJson(Map<String, dynamic> jsonRes) => References(
        referenceTitle: asT<String>(jsonRes['reference_title'])!,
        referenceDescription: asT<String>(jsonRes['reference_description'])!,
        referenceUrl: asT<String>(jsonRes['reference_url'])!,
        referenceButtonText: asT<String>(jsonRes['reference_button_text'])!,
      );

  String referenceTitle;
  String referenceDescription;
  String referenceUrl;
  String referenceButtonText;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'reference_title': referenceTitle,
        'reference_description': referenceDescription,
        'reference_url': referenceUrl,
        'reference_button_text': referenceButtonText,
      };

  References clone() => References.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Documents {
  Documents({
    required this.documentName,
    required this.documentFile,
  });

  factory Documents.fromJson(Map<String, dynamic> jsonRes) => Documents(
        documentName: asT<String>(jsonRes['document_name'])!,
        documentFile: Document_file.fromJson(
            asT<Map<String, dynamic>>(jsonRes['document_file'])!),
      );

  String documentName;
  Document_file documentFile;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'document_name': documentName,
        'document_file': documentFile,
      };

  Documents clone() => Documents.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Document_file {
  Document_file({
    required this.url,
  });

  factory Document_file.fromJson(Map<String, dynamic> jsonRes) => Document_file(
        url: asT<String>(jsonRes['url'])!,
      );

  String url;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
      };

  Document_file clone() => Document_file.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
