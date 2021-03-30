import 'package:bro/blocs/simple_bloc_observer.dart';
import 'package:bro/views/widgets/extract_route_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      },
      home: BottomNavBar(),
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
            onTap: () => Navigator.of(context).pushNamed('/courseList'),
          ),
          ListTile(
            title: Text('CategoryView'),
            onTap: () => Navigator.of(context).pushNamed('/categoryList'),
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