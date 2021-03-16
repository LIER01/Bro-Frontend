//import "package:graphql/client.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLProvider {
  GraphQLClient _client;

  GraphQLProvider() {
    HttpLink link = HttpLink("https://bro-strapi.herokuapp.com/graphql/");

    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic> variables}) async {
    QueryOptions options =
        QueryOptions(document: gql(query), variables: variables);

    final result = await _client.query(options);

    return result;
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic> variables}) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables);

    final result = await _client.mutate(options);

    return result;
  }
}
