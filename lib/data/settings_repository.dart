import 'dart:async';
import 'package:bro/data/queries/settings_queries.dart';
import 'package:flutter/cupertino.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final GraphQLClient client;

  SettingsRepository({required this.client});

  Future<QueryResult> getLanguages() async {
    debugPrint("yolo");
    debugPrint("y");
    final _options = WatchQueryOptions(
      document: parseString(getLanguagesQuery),
      fetchResults: true,
      variables: <String, dynamic>{},
    );

    return await client.query(_options);
  }

  static void setSelectedLang(String lang) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('lang', lang));
  }

  Future<String> getSelectedLang() {
    return SharedPreferences.getInstance()
        .then((value) => value.getString('lang') ?? 'NO');
  }

  Future<QueryResult> getPublishers() async {
    final _options = WatchQueryOptions(
      document: parseString(getPublishersQuery),
      variables: {},
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
