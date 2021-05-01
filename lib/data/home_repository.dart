import 'dart:async';

import 'package:bro/data/queries/home_view_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeRepository {
  final GraphQLClient client;

  HomeRepository({required this.client});

  Future<QueryResult> getHome() async {
    final _options = WatchQueryOptions(
      document: parseString(getHomeQuery),
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
