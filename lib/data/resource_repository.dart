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

  Future<QueryResult> getResources(
      String lang_slug, String category, bool recommended) async {
    WatchQueryOptions _options;
    recommended
        ? _options = WatchQueryOptions(
            document: parseString(getRecommendedResourcesQuery),
            fetchResults: true,
            variables: <String, dynamic>{
              'lang': lang_slug,
            },
          )
        : _options = WatchQueryOptions(
            document: parseString(getResourcesQuery),
            fetchResults: true,
            variables: <String, dynamic>{
              'lang': lang_slug,
              'category': int.parse(category),
            },
          );

    return await client.query(_options);
  }
}
