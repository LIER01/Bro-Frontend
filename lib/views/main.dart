//import 'home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../utils/api.dart';
import 'course/Course.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              primarySwatch: Colors.blue,
            ),
            home: CourseView() //MyHomePage(title: 'Flutter Demo Home Page'),
            ),
        client: client);
  }
}
