import 'dart:async';
import 'package:bro/data/queries/settings_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Contains The different selectable languages, fetched from the backend.
class SettingsRepository {
  final GraphQLClient client;

  SettingsRepository({required this.client});

  Future<QueryResult> getLanguages() async {
    final _options = WatchQueryOptions(
      document: parseString(getLanguagesQuery),
      fetchResults: true,
      variables: <String, dynamic>{},
    );
    return await client.query(_options);
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
