import 'dart:async';
import 'package:bro/data/queries/article_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ArticleRepository {
  final GraphQLClient client;

  ArticleRepository({required this.client});

  Future<QueryResult> getArticles(int start, int limit) async {
    final _options = WatchQueryOptions(
      document: parseString(getArticlesQuery),
      fetchResults: true,
      variables: <String, dynamic>{'start': start, 'limit': limit},
    );

    return await client.query(_options);
  }

  Future<QueryResult> getArticle(int i) async {
    final _options = WatchQueryOptions(
      document: parseString(getArticleQuery),
      variables: {'article_id': i},
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
