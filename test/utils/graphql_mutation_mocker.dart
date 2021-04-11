import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

/// Mockclient
class MockClient extends Mock implements Client {
  MockClient({
    this.mockedResult,
    this.mockedStatus = 200,
  });

  final Map<String, dynamic>? mockedResult;
  final int mockedStatus;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return Future<StreamedResponse>.value(
      StreamedResponse(
        Stream.value(utf8.encode(jsonEncode(mockedResult))),
        mockedStatus,
      ),
    );
  }
}

/// GraphqlMutationMocker should be passed your mockedResult and the widget to be rendered
class GraphQLMutationMocker extends StatelessWidget {
  const GraphQLMutationMocker({
    required this.child,
    this.mockedResult = const {},
    this.mockedStatus = 200,
    this.url = 'http://url',
    this.storagePrefix = 'test',
  });

  final Widget child;

  final Map<String, dynamic> mockedResult;

  final int mockedStatus;

  final String url;

  final String storagePrefix;

  @override
  Widget build(BuildContext context) {
    final mockClient = MockClient(
      mockedResult: mockedResult,
      mockedStatus: mockedStatus,
    );
    final httpLink = HttpLink(
      url,
      httpClient: mockClient,
    );
    final graphQLClient = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(
            store: InMemoryStore(),
            partialDataPolicy: PartialDataCachePolicy.accept),
        link: httpLink,
      ),
    );
    return GraphQLProvider(
      client: graphQLClient,
      child: child,
    );
  }
}
