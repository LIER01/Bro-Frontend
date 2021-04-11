import 'dart:async';
import 'package:bro/data/queries/queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CourseRepository {
  final GraphQLClient client;

  CourseRepository({required this.client});

  // Course type should be made in a models/ directory
  Future<QueryResult> getCourses(int start, int limit) async {
    final _options = WatchQueryOptions(
      document: parseString(getCoursesQuery),
      fetchResults: true,
      variables: <String, dynamic>{'start': start, 'limit': limit},
    );

    return await client.query(_options);
  }

  Future<QueryResult> getCourse(int i) async {
    final _options = WatchQueryOptions(
      document: parseString(getCourseQuery),
      variables: {'course_id': i},
      fetchResults: true,
    );

    return await client.query(_options);
  }

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
}
