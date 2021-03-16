import 'package:bro/utils/api.dart';
import 'package:bro/views/article_view.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: MaterialApp(
          title: 'GraphQl Article',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            primaryColor: Colors.teal,
            accentColor: Colors.tealAccent,
            brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              centerTitle: true,
              elevation: 0,
            ),
            cardTheme: CardTheme(elevation: 5.0),
            iconTheme: IconThemeData(size: 18.0, color: Colors.white),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              headline6: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.teal,
              ),
              subtitle1: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.15,
                color: Colors.black,
              ),
              subtitle2: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.10,
                color: Colors.black,
              ),
              caption: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.40,
              ),
            ),
          ),
          home: CourseListView(),
        ),
        client: client);
  }
}
