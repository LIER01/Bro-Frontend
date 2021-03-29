import 'package:bro/blocs/simple_bloc_observer.dart';
import 'package:bro/views/widgets/extract_route_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// ignore: library_prefixes
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  Bloc.observer = SimpleBlocObserver();
  await DotEnv.load();
  runApp(App());
}

// This widget is the root of your application.
class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  GraphQLClient _client() {
    final _link = HttpLink(env['API_URL'] + '/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bro',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
        scaffoldBackgroundColor: Colors.grey.shade50,
        brightness: Brightness.light,
        // Don't mess with this without reading: https://github.com/flutter/flutter/issues/50606
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade50,
          brightness: Brightness.light,
          textTheme: Typography.material2018()
              .black
              .copyWith(
                  headline6: GoogleFonts.notoSans(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ))
              .merge(Typography.englishLike2018),
          iconTheme: const IconThemeData(color: Colors.teal),
          actionsIconTheme: const IconThemeData(color: Colors.teal),
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(elevation: 5.0),
        iconTheme: IconThemeData(size: 18.0, color: Colors.white),
        textTheme: TextTheme(
          headline1: GoogleFonts.notoSans(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
          headline4: GoogleFonts.notoSans(color: Colors.teal),
          headline6: GoogleFonts.notoSans(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.teal,
          ),
          subtitle1: GoogleFonts.notoSans(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.15,
            color: Colors.black,
          ),
          subtitle2: GoogleFonts.notoSans(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.10,
            color: Colors.black,
          ),
          caption: GoogleFonts.notoSans(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.40,
          ),
          button: GoogleFonts.notoSans(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.125,
          ),
        ),
      ),
      routes: {
        ExtractCourseDetailScreen.routeName: (context) =>
            ExtractCourseDetailScreen(client: _client()),
        ExtractCourseListScreen.routeName: (context) =>
            ExtractCourseListScreen(client: _client()),
        ExtractCategoryListScreen.routeName: (context) =>
            ExtractCategoryListScreen(client: _client()),
        ExtractRecommendedScreen.routeName: (context) =>
            ExtractRecommendedScreen(client: _client()),
      },
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Velkommen til Bro!'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('CourseListView'),
            onTap: () => Navigator.of(context).pushNamed('/courseList'),
          ),
          ListTile(
            title: Text('CategoryView'),
            onTap: () => Navigator.of(context).pushNamed('/categoryList'),
          ),
          ListTile(
            title: Text('HomeView'),
            onTap: () =>
                Navigator.of(context).pushNamed('/recommendedCourseList'),
          ),
        ],
      ),
    );
  }
}
