import 'dart:async';

import 'package:bro/data/queries/home_view_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeRepository {
  final GraphQLClient client;

  HomeRepository({required this.client});

  // Course type should be made in a models/ directory
  Future<QueryResult> getRecommendedCourses(
      int start, int limit, String lang_slug) async {
    final _options = WatchQueryOptions(
      document: parseString(getRecommendedCoursesQuery),
      fetchResults: true,
      variables: <String, dynamic>{
        'lang_slug': lang_slug,
        'start': start,
        'limit': limit
      },
    );

    return await client.query(_options);
  }

  Future<QueryResult> getHome() async {
    final _options = WatchQueryOptions(
      document: parseString(getHomeQuery),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> getRecommendedLangResources(
      int start, int limit, String lang) async {
    final _options = WatchQueryOptions(
      document: parseString(getRecommendedLangResourcesQuery),
      fetchResults: true,
      variables: <String, dynamic>{
        'start': start,
        'limit': limit,
        'lang': lang
      },
    );

    return await client.query(_options);
  }
}
