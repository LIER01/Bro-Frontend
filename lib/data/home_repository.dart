import 'dart:async';

import 'package:bro/data/queries/home_view_queries.dart';
import 'package:bro/data/queries/queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeRepository {
  final GraphQLClient client;

  HomeRepository({required this.client});

  // Course type should be made in a models/ directory
  Future<QueryResult> getRecommendedCourses(
      String lang_slug, int start, int limit) async {
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

  Future<QueryResult> getRecommendedNonLangResources(
      int start, int limit) async {
    final _options = WatchQueryOptions(
      document: parseString(getRecommendedNonLangResourcesQuery),
      fetchResults: true,
      variables: <String, dynamic>{'start': start, 'limit': limit},
    );

    return await client.query(_options);
  }
}
