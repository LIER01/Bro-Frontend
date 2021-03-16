import 'package:bro/blocs/course/course_bucket.dart';
import 'package:bro/net/queries.dart';
import 'package:bro/views/course/course_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CourseListView extends StatefulWidget {
  CourseListView({Key key}) : super(key: key);

  @override
  _CourseListViewState createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  List data = [];

  @override
  void initState() {
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Kurs"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseStates>(
      builder: (BuildContext context, CourseStates state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: LinearProgressIndicator(),
          );
        } else if (state is Failed) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Center(child: Text(state.error)),
          );
        } else {
          data = (state as Success).data["courses"];
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
          );
        }
      },
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          var item = data[index];
          return CourseListTile(
            title: item['title'],
            description: item['description'],
            length: item['questions'].length,
            time: item['questions'].length + item['slides'].length,
            difficulty: 'Middels',
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(getCoursesQuery)),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Course List",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          body: Center(
            child: result.hasException
                ? Text(result.exception.toString())
                : result.isLoading
                    ? CircularProgressIndicator()
                    : CourseList(
                        list: result.data["courses"], onRefresh: refetch),
          ),
        );
      },
    );
  } 
  */
}

class CourseList extends StatelessWidget {
  CourseList({@required this.list, @required this.onRefresh});

  final List list;
  final onRefresh;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        debugPrint("Current item:" + item['title']);
        return CourseListTile(
          title: item['title'],
          description: item['description'],
          length: item['questions'].length,
          time: item['questions'].length + item["slides"].length,
          difficulty: "Middels",
        );
      },
    );
  }
}
