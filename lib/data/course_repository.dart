import "dart:async";
import 'dart:developer';

import 'package:bro/data/graphql_data_provider.dart';
import 'package:bro/data/queries/queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import "package:meta/meta.dart";

class CourseRepository {
  final GraphQLDataProvider provider;

  CourseRepository({@required this.provider}) : assert(provider != null);

  // Course type should be made in a models/ directory
  Future<QueryResult> getCourses() async {
    final WatchQueryOptions _options =
        WatchQueryOptions(document: parseString(getCoursesQuery));

    return await provider.performQuery(_options);
  }
}
