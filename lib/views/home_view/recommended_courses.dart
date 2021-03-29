import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/course_list/recommended_course_list_bloc.dart';
import 'package:bro/views/course/course_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bro/utils/navigator_arguments.dart';

class RecommendedCourseListView extends StatefulWidget {
  RecommendedCourseListView({Key key}) : super(key: key);

  @override
  _RecommendedCourseListViewState createState() =>
      _RecommendedCourseListViewState();
}

class _RecommendedCourseListViewState extends State<RecommendedCourseListView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  RecommendedCourseListBloc _courseListBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _courseListBloc = BlocProvider.of<RecommendedCourseListBloc>(context);
    _courseListBloc.add(CourseListRequested());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Hjem'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedCourseListBloc, CourseListState>(
        // ignore: missing_return
        builder: (context, state) {
      //log(state.toString());
      if (state is Loading) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: LinearProgressIndicator(),
        );
      }

      if (state is Failed) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: Center(child: Text('Det har skjedd en feil')),
        );
      }
      if (state is Success) {
        return Scaffold(
            appBar: _buildAppBar(),
            body: SingleChildScrollView(
                child: ExpansionPanelList.radio(children: [
              ExpansionPanelRadio(
                  canTapOnHeader: true,
                  value: 'hey',
                  headerBuilder: (context, isExpanded) =>
                      ListTile(title: Text('Anbefalte Kurs')),
                  body: Column(
                      children: state.courses
                          .asMap()
                          .keys
                          .toList()
                          .map((index) => GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                  '/courseDetail',
                                  arguments: CourseDetailArguments(
                                      courseId: index + 1)),
                              child: CourseListTile(
                                course: state.courses[index],
                              )))
                          .toList())),
              ExpansionPanelRadio(
                  canTapOnHeader: true,
                  value: 'Anbefalte Artikler',
                  headerBuilder: (context, isExpanded) => ListTile(
                      leading: null, title: Text('Anbefalte Artikler')),
                  body: Card())
            ])));
      }
      ;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _courseListBloc.add(CourseListRequested());
    }
  }
}
