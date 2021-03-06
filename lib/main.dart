import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/blocs/simple_bloc_observer.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
// ignore: library_efixes
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

Future main() async {
  Bloc.observer = SimpleBlocObserver();
  await dot_env.load();
  final preferredLanguageRepository = PreferredLanguageRepository();
  runApp(App(preferredLanguageRepository: preferredLanguageRepository));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
            onTap: () => Navigator.of(context).pushNamed('/homeView'),
          ),
        ],
      ),
    );
  }
}

// This widget is the root of your application.
class App extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  final PreferredLanguageRepository preferredLanguageRepository;

  App({required this.preferredLanguageRepository});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
            fontSize: 95.0,
            fontWeight: FontWeight.normal,
            letterSpacing: -1.5,
            color: Colors.teal,
          ),
          headline2: GoogleFonts.notoSans(
            fontSize: 59.0,
            fontWeight: FontWeight.normal,
            letterSpacing: -0.5,
            color: Colors.teal,
          ),
          headline3: GoogleFonts.notoSans(
            fontSize: 48.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.0,
            color: Colors.teal,
          ),
          headline4: GoogleFonts.notoSans(
            fontSize: 34.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.25,
            color: Colors.teal,
          ),
          headline5: GoogleFonts.notoSans(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.0,
            color: Colors.teal,
          ),
          headline6: GoogleFonts.notoSans(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
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
          bodyText1: GoogleFonts.notoSans(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
          bodyText2: GoogleFonts.notoSans(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.25,
          ),
          button: GoogleFonts.notoSans(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25,
            color: Colors.white,
          ),
          caption: GoogleFonts.notoSans(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.40,
          ),
          overline: GoogleFonts.notoSans(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            letterSpacing: 1.5,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) =>
            PreferredLanguageBloc(repository: preferredLanguageRepository),
        child: BottomNavBar(),
      ),
    );
  }
}
