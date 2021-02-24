import 'package:bro/api_example/queries.dart';
import 'package:bro/models/home.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<Home> futureHome;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(getHomeViewQuery)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return Scaffold(
            body: Center(
                child: result.hasException
                    ? Text(result.exception.toString())
                    : result.isLoading
                    ? CircularProgressIndicator()
                    : Body(
                    header: result.data['home']['header'],
                    introduction: result.data['home']['introduction'], onRefresh:
                refetch)),
          );
        });
  }
}

class Body extends StatelessWidget {
  Body(
      {@required this.header, @required this.introduction, @required this.onRefresh});

  final header;
  final introduction;
  final onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.deepPurple),
        title: Text(header,style: TextStyle(color: Colors.deepPurple),),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (BuildContext context){
            return[
              PopupMenuItem(child: Text('Flutter')),
              PopupMenuItem(child: Text('Android')),
            ];
          })
        ],
      ),
      body:Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(introduction)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Les Mer'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
