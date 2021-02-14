import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../article/queries.dart';

final HttpLink httpLink = HttpLink(
  'https://bro-strapi.herokuapp.com/graphql',
);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: httpLink,
  ),
);
