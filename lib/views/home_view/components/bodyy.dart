import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body(this.header, this.introduction);

  final String header;
  final String introduction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(header),
        ),
        body: Center(child: Text(introduction)));
  }
}
