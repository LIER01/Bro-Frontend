import 'dart:io';

import 'package:bro/utils/api.dart';
import 'package:bro/views/home_view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'graphql_mutation_mocker.dart';


void main() {
    MockHttpClient mockHttpClient;
    HttpLink httpLink;
    ValueNotifier<GraphQLClient> client;
    setUp(() async {
      mockHttpClient = MockHttpClient();
      httpLink = HttpLink('https://unused/graphql');
      client = ValueNotifier(
        GraphQLClient(
          cache: GraphQLCache(store: InMemoryStore()),
          link: httpLink,
        ),
      );
    });

    testWidgets('Homeview test', (tester) async {
      HttpOverrides.runZoned(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
          GraphQLProvider(client: client, child: HomeView(title: 'yolo')));
        });
    });

}


class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}