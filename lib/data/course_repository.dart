import 'dart:async';
import 'package:bro/data/queries/queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CourseRepository {
  final GraphQLClient client;

  CourseRepository({required this.client});

  Future<QueryResult> getLangCourses(
      String lang_slug, int start, int limit) async {
    final _options = WatchQueryOptions(
      document: parseString(langCoursesQuery),
      fetchResults: true,
      variables: <String, dynamic>{
        'lang_slug': lang_slug,
        'start': start,
        'limit': limit
      },
    );

    return await client.query(_options);
  }

  Future<QueryResult> getNonLangCourses(int start, int limit) async {
    final _options = WatchQueryOptions(
      document: parseString(nonLangCoursesQuery),
      fetchResults: true,
      variables: <String, dynamic>{'start': start, 'limit': limit},
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
