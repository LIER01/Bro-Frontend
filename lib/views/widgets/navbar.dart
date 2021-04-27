import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'extract_route_args.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PreferredLanguageBloc _preferredLanguageBloc;
  @override
  void initState() {
    super.initState();
    _preferredLanguageBloc = BlocProvider.of<PreferredLanguageBloc>(context);
    _preferredLanguageBloc.add(PreferredLanguageRequested());
  }

  int _selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _NavKeys = [
    _homeNavKey,
    _resourceNavKey,
    _courseNavKey,
    _settingsNavKey,
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
      return Future<bool>.value(false);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return Future<bool>.value(true);
    }
    //throw Exception('Something went wrong');
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
              ResourceTab(),
              CourseTab(),
              SettingsTab(),
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
                label: 'Ressurser',
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
  late PreferredLanguageBloc _preferredLanguageBloc;
  @override
  void initState() {
    super.initState();
    _preferredLanguageBloc = BlocProvider.of<PreferredLanguageBloc>(context);
  }

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
                    return ExtractHomeScreen(
                        client: _client(),
                        preferredLanguageBloc: _preferredLanguageBloc);
                  case ExtractCourseDetailScreen.routeName:
                    return ExtractCourseDetailScreen(
                      client: _client(),
                      preferredLanguageBloc: _preferredLanguageBloc,
                    );
                  case ExtractResourceDetailScreen.routeName:
                    return ExtractResourceDetailScreen(client: _client());
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
  late PreferredLanguageBloc _preferredLanguageBloc;
  @override
  void initState() {
    super.initState();
    _preferredLanguageBloc = BlocProvider.of<PreferredLanguageBloc>(context);
  }

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
                    return ExtractCourseListScreen(
                        client: _client(),
                        preferredLanguageBloc: _preferredLanguageBloc);
                  case ExtractCourseDetailScreen.routeName:
                    return ExtractCourseDetailScreen(
                        client: _client(),
                        preferredLanguageBloc: _preferredLanguageBloc);
                  default:
                    return ExtractCourseListScreen(
                        client: _client(),
                        preferredLanguageBloc: _preferredLanguageBloc);
                }
              });
        });
  }
}

class ResourceTab extends StatefulWidget {
  @override
  _ResourceTabState createState() => _ResourceTabState();
}

GlobalKey<NavigatorState> _resourceNavKey = GlobalKey<NavigatorState>();

class _ResourceTabState extends State<ResourceTab> {
  late PreferredLanguageBloc _preferredLanguageBloc;
  @override
  void initState() {
    super.initState();
    _preferredLanguageBloc = BlocProvider.of<PreferredLanguageBloc>(context);
  }

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
        key: _resourceNavKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case ExtractCategoryListScreen.routeName:
                    return ExtractCategoryListScreen(client: _client());
                  case ExtractResourceListScreen.routeName:
                    return ExtractResourceListScreen(
                      client: _client(),
                      preferredLanguageBloc: _preferredLanguageBloc,
                    );
                  case ExtractResourceDetailScreen.routeName:
                    return ExtractResourceDetailScreen(client: _client());
                  case ExtractResourseDetailWebViewScreen.routeName:
                    return ExtractResourseDetailWebViewScreen();
                  default:
                    return ExtractCategoryListScreen(client: _client());
                }
              });
        });
  }
}

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

GlobalKey<NavigatorState> _settingsNavKey = GlobalKey<NavigatorState>();

class _SettingsTabState extends State<SettingsTab> {
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
        key: _settingsNavKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case ExtractSettingsScreen.routeName:
                    return ExtractSettingsScreen(client: _client());
                  default:
                    return ExtractSettingsScreen(client: _client());
                }
              });
        });
  }
}
