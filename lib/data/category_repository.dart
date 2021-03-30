import 'dart:async';

import 'package:bro/data/queries/category_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class CategoryRepository {
  final GraphQLClient client;

  CategoryRepository({@required this.client}) : assert(client != null);

  // Course type should be made in a models/ directory
  Future<QueryResult> getCategories() async {
    final _options = WatchQueryOptions(
      document: parseString(getCategoryQuery),
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
