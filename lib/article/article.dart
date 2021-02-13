import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'api.dart';
import 'package:flutter/foundation.dart';

class ArticleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("Test");
    return GraphQLProvider(
        child: MaterialApp(
          title: 'GraphQl Article',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ListPage(),
        ),
        client: client);
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final newTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(getArticlesQuery)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return Scaffold(
            appBar: AppBar(
              title: Text("TODO App With GraphQL"),
            ),
            body: Center(
                child: result.hasException
                    ? Text(result.exception.toString())
                    : result.isLoading
                        ? CircularProgressIndicator()
                        : TaskList(
                            list: result.data['articles'], onRefresh: refetch)),
          );
        });
  }
}

class TaskList extends StatelessWidget {
  TaskList({@required this.list, @required this.onRefresh});

  final list;
  final onRefresh;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.list.length,
      itemBuilder: (context, index) {
        final task = this.list[index];
        return ListTile(
          title: Text(task['title']),
        );
      },
    );
  }
}
