import 'dart:convert';
import 'package:bro/models/home.dart';
import 'package:http/http.dart' as http;

final String getHomePageQuery = '''
query {
    header,
    introduction,
}
''';

Future<Home> fetchHome() async {
  final response = await http.get('http://localhost:1337/home');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Home.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load homepage');
  }
}
