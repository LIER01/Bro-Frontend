//import "package:graphql/client.dart";
import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLDataProvider {
  GraphQLClient _client;

  GraphQLProvider() {
    HttpLink link = HttpLink('https://bro-strapi.herokuapp.com/graphql/');

    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }

  Future<QueryResult> performQuery(WatchQueryOptions options) async {
    return await _client.query(options);

    /*
    try {
      QueryOptions options =
          QueryOptions(document: gql(query), variables: null);

      final result = await _client.query(options);
      if (result.hasException) {
        log('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
        //log('clientErrors: ${result.exception.clientException.toString()}');
      }
      return result;
    } catch (e) {
      //log(e.toString());
      //log("hallo");
      return e;
    }*/
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic> variables}) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables);

    final result = await _client.mutate(options);

    return result;
  }
}
