import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResourceDetailWebView extends StatefulWidget {
  final String url;

  const ResourceDetailWebView({Key? key, required this.url}) : super(key: key);

  @override
  _ResourceDetailWebViewState createState() => _ResourceDetailWebViewState(url);
}

class _ResourceDetailWebViewState extends State<ResourceDetailWebView> {
  late final String _url;
  final _key = UniqueKey();

  _ResourceDetailWebViewState(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_url),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: _url,
          key: _key,
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}
