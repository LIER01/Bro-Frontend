import 'package:bro/data/queries/resource_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ResourceRepository {
  final GraphQLClient client;

  ResourceRepository({required this.client});

  Future<QueryResult> getResource(String lang, String group) async {
    final _options = WatchQueryOptions(
      document: parseString(getResourceQuery),
      fetchResults: true,
      variables: <String, dynamic>{'lang': lang, 'group': group},
    );

    return await client.query(_options);
  }
}
