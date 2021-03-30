import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/blocs/simple_bloc_observer.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/views/course/course.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:bro/views/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bro/assets/globals.dart';
import 'package:bro/views/widgets/navbar.dart';
void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(App());
}

// This widget is the root of your application.
class App extends StatelessWidget {
  App({Key key}) : super(key: key);

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
              .copyWith(headline6: TextStyle(color: Colors.teal))
              .merge(Typography.englishLike2018),
          iconTheme: const IconThemeData(color: Colors.teal),
          actionsIconTheme: const IconThemeData(color: Colors.teal),
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
      routes: {
        'course-view': (_) => BlocProvider(
              create: (context) => CourseListBloc(
                repository: CourseRepository(
                  client: _client(),
                ),
              ),
              child: CourseListView(),
            ),
        'course-detail': (_) => BlocProvider(
              create: (context) => CourseDetailBloc(
                repository: CourseRepository(
                  client: _client(),
                ),
              ),
              child: CourseDetailView(),
            ),
      },
      home: BottomNavBar(),
    );
  }

  GraphQLClient _client() {
    final _link = HttpLink('https://bro-strapi.herokuapp.com/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          ListTile(
            title: Text('CourseListView'),
            onTap: () => Navigator.of(context).pushNamed('course-detail'),
          ),
        ],
    );
  }
}
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _appBarOptions =[Text('Velkommen til Bro!'),Text('Artikler'),Text('Kurs'),Text('Instillinger'),];
  final List<Widget> _widgetOptions =[
    //har prøvd å sette inn Home() osv, men appen laster ikke når jeg gjør det.
    Home(),
    Text(
      'Index 1: Artikler',
    ),
    Text(
      'Index 2: Kurs',
    ),
    Text(
      'Index 3: Instillinger',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
    //Attempting to make the change of widget to an ontapped event since commented out body solution renders navbar in conflict with non-_widgetoption page
    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _appBarOptions[_selectedIndex],),
      body:  _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: 'Hjem',
          backgroundColor: Colors.teal,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.book),
          label: 'Artikler',
          backgroundColor: Colors.teal,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidCheckSquare),
          label: 'Kurs',
          backgroundColor: Colors.teal,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.cog),
          label: 'Instillinger',
          backgroundColor: Colors.teal,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.tealAccent,
      onTap: _onItemTapped,
      ),
    );
  }
}