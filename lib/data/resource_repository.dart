import 'package:bro/data/queries/home_view_queries.dart';
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

  Future<QueryResult> getLangResources(
      String lang_slug, String category,bool recommended) async {
    final _options;
    recommended ? _options = WatchQueryOptions(
      document: parseString(getRecommendedLangResourcesQuery),
      fetchResults: true,
      variables: <String, dynamic>{
        'lang': lang_slug
        'start': 0,
        'limit': 3
      },
    ) :
    _options = WatchQueryOptions(
      document: parseString(getLangResourcesQuery),
      fetchResults: true,
      variables: <String, dynamic>{
        'lang': lang_slug,
        'category': int.parse(category),
/*         'start': start,
        'limit': limit */
      },
    );

    return await client.query(_options);
  }

  Future<QueryResult> getNonLangResources(int start, int limit) async {
    final _options = WatchQueryOptions(
      document: parseString(getNonLangResourcesQuery),
      fetchResults: true,
      variables: <String, dynamic>{'start': start, 'limit': limit},
    );

    return await client.query(_options);
  }
}
