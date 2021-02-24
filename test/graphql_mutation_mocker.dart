import 'dart:io';

import 'package:mockito/mockito.dart';

import 'image_test_data.dart';

MockHttpClient createMockImageHttpClient(SecurityContext _) {
  final MockHttpClient client = MockHttpClient();
  final MockHttpClientRequest request = MockHttpClientRequest();
  final MockHttpClientResponse response = MockHttpClientResponse();
  final MockHttpHeaders headers = MockHttpHeaders();
  final Map<String, dynamic> mockedData = <String, dynamic>{
    'data': {
      'home': {'header': 'hey', 'introduction': 'jojojo'}
    }
  };
  when(client.getUrl(any))
      .thenAnswer((_) => Future<HttpClientRequest>.value(request));
  when(request.headers).thenReturn(headers);
  when(request.close())
      .thenAnswer((_) => Future<HttpClientResponse>.value(response));
  when(response.contentLength).thenReturn(100);
  when(response.statusCode).thenReturn(HttpStatus.ok);
  when(response.compressionState)
      .thenReturn(HttpClientResponseCompressionState.notCompressed);
  when(response.listen(any)).thenAnswer((Invocation invocation) {
    final void Function(List<int>) onData =
        invocation.positionalArguments[0] as void Function(List<int>);
    final void Function() onDone =
        invocation.namedArguments[#onDone] as void Function();
    final void Function(Object, [StackTrace]) onError = invocation
        .namedArguments[#onError] as void Function(Object, [StackTrace]);
    final bool cancelOnError =
        invocation.namedArguments[#cancelOnError] as bool;
    return Stream<List<int>>.fromIterable(<List<int>>[kTransparentImage])
        .listen(onData,
            onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  });
  return client;
}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}
