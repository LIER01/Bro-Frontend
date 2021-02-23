import 'package:bro/models/home.dart';
import 'package:bro/screens/homepage/queries.dart';
import 'package:flutter/material.dart';

import 'components/bodyy.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Home> futureHome;
  @override
  void initState() {
    super.initState();
    futureHome = fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Home>(
      future: futureHome,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Body(snapshot.data.header, snapshot.data.introduction);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
