import "package:flutter/material.dart";

class ArticleView extends StatefulWidget {
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    final body = "Dette er en artikkel kropp";
    return Text(body);
  }
}
