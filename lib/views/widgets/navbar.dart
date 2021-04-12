import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'extract_route_args.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _NavKeys = [
    _homeNavKey,
    _articleNavKey,
    _courseNavKey,
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index != _selectedIndex) {
        _selectedIndex = index;
      } else {
        while (_NavKeys[_selectedIndex].currentState!.canPop()) {
          _NavKeys[_selectedIndex]
              .currentState
              ?.pop(_NavKeys[_selectedIndex].currentContext);
        }
      }
    });
  }

  Future<bool> _androidBackButtonPressed() {
    if (_NavKeys[_selectedIndex].currentState!.canPop()) {
      _NavKeys[_selectedIndex]
          .currentState
          ?.pop(_NavKeys[_selectedIndex].currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
    throw Exception('Something went wrong');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _androidBackButtonPressed,
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              HomeTab(),
              ArticleTab(),
              CourseTab(),
            ],
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
        ));
  }
}

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();

class _HomeTabState extends State<HomeTab> {
  GraphQLClient _client() {
    final _link = HttpLink(env['API_URL']! + '/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: _homeNavKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case '/':
                    return ExtractRecommendedScreen(client: _client());
                  case ExtractCourseDetailScreen.routeName:
                    return ExtractCourseDetailScreen(client: _client());
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }
              });
        });
  }
}

class CourseTab extends StatefulWidget {
  @override
  _CourseTabState createState() => _CourseTabState();
}

GlobalKey<NavigatorState> _courseNavKey = GlobalKey<NavigatorState>();

class _CourseTabState extends State<CourseTab> {
  GraphQLClient _client() {
    final _link = HttpLink(env['API_URL']! + '/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: _courseNavKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case ExtractCourseListScreen.routeName:
                    return ExtractCourseListScreen(client: _client());
                  case ExtractCourseDetailScreen.routeName:
                    return ExtractCourseDetailScreen(client: _client());
                  default:
                    return ExtractCourseListScreen(client: _client());
                }
              });
        });
  }
}

class ArticleTab extends StatefulWidget {
  @override
  _ArticleTabState createState() => _ArticleTabState();
}

GlobalKey<NavigatorState> _articleNavKey = GlobalKey<NavigatorState>();

class _ArticleTabState extends State<ArticleTab> {
  GraphQLClient _client() {
    final _link = HttpLink(env['API_URL']! + '/graphql');

    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: _link,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: _articleNavKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case ExtractCategoryListScreen.routeName:
                    return ExtractCategoryListScreen(client: _client());
                  case ExtractResourceDetailScreen.routeName:
                    return ExtractResourceDetailScreen(client: _client());
                  default:
                    return ExtractCategoryListScreen(client: _client());
                }
              });
        });
  }
}
