import 'dart:async';
import 'package:bro/data/queries/course_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CourseRepository {
  final GraphQLClient client;

  CourseRepository({required this.client});

  /// Returns recommended courses if recommended is true
  Future<QueryResult> getCourses(
      String lang_slug, int start, int limit, bool recommended) async {
    var _options;
    recommended
        ? _options = WatchQueryOptions(
            document: parseString(getRecommendedCoursesQuery),
            fetchResults: true,
            variables: <String, dynamic>{
                'lang_slug': lang_slug,
                'start': start,
                'limit': limit
              })
        : _options = WatchQueryOptions(
            document: parseString(getCoursesQuery),
            fetchResults: true,
            variables: <String, dynamic>{
              'lang_slug': lang_slug,
              'start': start,
              'limit': limit
            },
          );

    return await client.query(_options);
  }

  Future<QueryResult> getCourseQuery(String group, String lang) async {
    final _options = WatchQueryOptions(
      document: parseString(getCourse),
      fetchResults: true,
      variables: <String, dynamic>{'group_slug': group, 'lang_slug': lang},
    );

    return await client.query(_options);
  }
}
