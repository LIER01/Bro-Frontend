import 'package:bro/views/flutter-demo/demoscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bro/views/main.dart';
import 'package:bro/models/course.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'extract_route_args.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({this.navKey, Key key}) : super(key: key);
  var navKey = GlobalKey<NavigatorState>();

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List _widgetOptions = [
    '/',
    ExtractCategoryListScreen.routeName,
    ExtractCourseListScreen.routeName,
    ExtractCategoryListScreen.routeName,
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.navKey.currentState.pushNamed(_widgetOptions[index]);
      _selectedIndex = index;
    });
  }

  GraphQLClient _client() {
    final _link = HttpLink(env['API_URL'] + '/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: widget.navKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => Home();
              break;
            case ExtractCourseDetailScreen.routeName:
              builder =
                  (context) => ExtractCourseDetailScreen(client: _client());
              break;
            case ExtractCourseListScreen.routeName:
              builder = (context) => ExtractCourseListScreen(client: _client());
              break;
            case ExtractCategoryListScreen.routeName:
              builder =
                  (context) => ExtractCategoryListScreen(client: _client());
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
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