import 'dart:convert';

import 'package:flutter/src/material/dropdown.dart';

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
        data: Languages.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])!),
      );

  Languages data;

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

class Languages {
  Languages({
    required this.languages,
  });

  factory Languages.fromJson(Map<String, dynamic> jsonRes) {
    final List<Language>? languages =
        jsonRes['languages'] is List ? <Language>[] : null;
    if (languages != null) {
      for (final dynamic item in jsonRes['languages']!) {
        if (item != null) {
          languages.add(Language.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return Languages(
      languages: languages!,
    );
  }

  List<Language> languages;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'languages': languages,
      };

  Languages clone() => Languages.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
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

  String languageFullName;
  String slug;

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
