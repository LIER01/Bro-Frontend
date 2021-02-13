import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

final HttpLink httpLink = HttpLink(
  'https://bro-strapi.herokuapp.com/graphql',
);

// final AuthLink authLink = AuthLink(
//     getToken: () async =>
//         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjEzMjIyMTcyLCJleHAiOjE2MTU4MTQxNzJ9.zLy_4BuO8YJtMCne_fREXLDhITg0F2jRyJeH9BuABBM'
//     // OR
//     // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
//     );

//getAuthToken(String username, String password) async {
//   final response = await http.post(
//       'https://bro-strapi.herokuapp.com/auth/local',
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(
//           <String, String>{'identifier': username, 'password': password}));
//   debugPrint(response.body);
//   return jsonDecode(response.body)["jwt"];
// }

// final Link combinedLink = authLink.concat(httpLink);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: httpLink,
  ),
);

final String getArticlesQuery = """
query {
  articles {
    id,
    title,
    body
  }
}
""";
