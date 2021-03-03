import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            primarySwatch: Colors.teal,
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
      print('CONTEXT NULL              CONTEXT NULL');
      return Scaffold(body: Text('Context is null, yo'));
    }
    if (widget.list.isNotEmpty) {
      print(widget.list.length);
      return SizedBox(
          width: 1100,
          height: 1100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: PageScrollPhysics(),
              itemCount: widget.list.length,
              itemBuilder: (BuildContext context, int index) {
                return InfoCard(
                    title: widget.list[index]['title'],
                    description: widget.list[index]['description'],
                    image: widget.list[index]['image']);
              }));
    } else {
      print('LIST EMPTY');
      return Container(width: 0.0, height: 0.0);
    }

    /* if (widget.list.isNotEmpty) {
      print(widget.list);
      return Expanded(
          child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(parent: PageScrollPhysics()),
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              InfoCard(
                  title: widget.list[index]['title'],
                  description: widget.list[index]['description'],
                  image: widget.list[index]['image'])
            ],
          );
        },
      ));
    } else {
      return Container();
    } */
    /* ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(parent: PageScrollPhysics()),
      children: <Widget>[ */
    /* Container(
          width: 160.0,
          color: Colors.red,
        ),
        Container(
          width: 160.0,
          color: Colors.blue,
        ),
        Container(
          width: 160.0,
          color: Colors.green,
        ),
        Container(
          width: 160.0,
          color: Colors.yellow,
        ),
        Container(
          width: 160.0,
          color: Colors.orange,
        ), */
/*       ],
    ); */
    /* return FutureBuilder<List>(
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
        }); */

/*         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ), */
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
