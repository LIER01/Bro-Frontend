import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/views/course/course_list_tile.dart';
import 'package:bro/views/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bro/utils/navigator_arguments.dart';
import 'package:bro/views/widgets/extract_route_args.dart';

class CourseListView extends StatefulWidget {
  CourseListView({Key? key}) : super(key: key);

  @override
  _CourseListViewState createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late CourseListBloc _courseListBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _courseListBloc = BlocProvider.of<CourseListBloc>(context);
    _courseListBloc.add(CourseListRequested());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Kurs'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListBloc, CourseListState>(
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
            body: ListView.builder(
              itemCount: state.hasReachedMax
                  ? state.courses.length + 1
                  : state.courses.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.courses.length
                    ? BottomLoader()
                    : GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            ExtractCourseDetailScreen.routeName,
                            arguments: CourseDetailArguments(
                                courseId: state.courses[index].id)),
                        child: CourseListTile(
                          course: state.courses[index],
                        ),
                      );
              },
            ),
          );
        }
        return Scaffold(
          appBar: _buildAppBar(),
          body: Center(child: Text('Det har skjedd en feil')),
        );
      },
    );
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
