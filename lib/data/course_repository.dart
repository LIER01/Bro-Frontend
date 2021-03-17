import "dart:async";

import 'package:bro/data/queries/queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class CourseRepository {
  final GraphQLClient client;

  CourseRepository({@required this.client}) : assert(client != null);

  // Course type should be made in a models/ directory
  Future<QueryResult> getCourses() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(getCoursesQuery),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> getCourse(int i) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(getCourseQuery),
      variables: {'course_id': i},
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
