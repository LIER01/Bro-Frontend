import 'package:bro/data/queries/resource_queries.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class ResourceRepository {
  final GraphQLClient client;

  ResourceRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> getResource(String lang, String group) async {
    final _options = WatchQueryOptions(
      document: parseString(getResourceQuery),
      fetchResults: true,
      variables: <String, dynamic>{'lang': lang, 'group': group},
    );

    // TEMP
    final result = {
      'title': 'yoo',
      'description': 'Beskrivelse',
      'publisher': 'Lier',
      'category': 'Helse',
      'is_recommended': true,
      'references': [
        {
          'title': 'Referanse',
          'description': 'Referansebeskrivelse',
          'url': 'https://nhi.no',
          'button_text': 'NHI Referanse',
        }
      ]
    };

    return await client.query(_options);
  }
}
