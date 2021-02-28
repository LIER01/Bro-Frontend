import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../utils/api.dart';
import 'package:flutter/foundation.dart';
import 'queries.dart';
import 'InfoCard.dart';
import '../../assets/globals.dart' as globals;

class CourseApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: CourseView(),
        ),
        client: client);
  }
}

class CourseView extends StatefulWidget {
  CourseView({Key key}) : super(key: key);

  @override
  CourseViewState createState() => CourseViewState();
}

class CourseViewState extends State<CourseView> {
  final newTaskController = TextEditingController();
  Future<List> onRefresh;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(getCourseQuery)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return Scaffold(
            appBar: result.hasException
                ? AppBar(title: Text(result.exception.toString()))
                : (result.isLoading)
                    ? AppBar(title: Text("Loading"))
                    : AppBar(
                        title: Text(result.data['course']['title']),
                      ),
            body: Center(
                child: result.hasException
                    ? Text(result.exception.toString())
                    : (result.isLoading)
                        ? CircularProgressIndicator()
                        : CardContainerView(
                            list: result.data['course']['slides'],
                            onRefresh: onRefresh,
                            res: result,
                          )),
          );
        });
  }
}

class CardContainerView extends StatefulWidget {
  CardContainerView({
    Key key,
    this.list,
    this.onRefresh,
    this.res,
  }) : super(key: key);
  final Future<List> onRefresh;
  final List list;
  final QueryResult res;
  @override
  _CardContainerViewState createState() => _CardContainerViewState();
}

class _CardContainerViewState extends State<CardContainerView> {
  Future<List> futureList;
  @override
  Widget build(BuildContext context) {
    if (context == null) {
      return Text('Context is null, yo');
    }
    return FutureBuilder<List>(
        future: widget.onRefresh,
        builder: (BuildContext context, snapshot) {
          if (widget.list.isNotEmpty) {
            final index = 0;
            final card = widget.list[index];
            return InfoCard(
                title: card['title'],
                description: card['description'],
                image: card['image']);
          } else {
            return Container();
          }
        }

/*         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ), */
        ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
