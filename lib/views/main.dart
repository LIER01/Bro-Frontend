import 'package:bro/blocs/course/course_bucket.dart';
import 'package:bro/blocs/simple_bloc_observer.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/graphql_data_provider.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final CourseRepository courseRepository =
      CourseRepository(provider: GraphQLDataProvider());

  runApp(App(courseRepository: courseRepository));
}

// This widget is the root of your application.
class App extends StatelessWidget {
  final CourseRepository courseRepository;

  App({Key key, @required this.courseRepository})
      : assert(courseRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        home: BlocProvider(
          create: (BuildContext context) =>
              CourseBloc(repository: courseRepository)..add(CourseRequested()),
          child: CourseListView(),
        ));
  }
}
