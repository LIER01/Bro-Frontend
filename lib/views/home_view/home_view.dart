import 'package:bro/blocs/course_list/course_list_bloc.dart';
import 'package:bro/blocs/course_list/course_list_state.dart' as ck;
import 'package:bro/blocs/home/home_bloc.dart';
import 'package:bro/blocs/home/home_event.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/blocs/resource_list/resource_list_bloc.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/views/course/course_list_tile.dart';
import 'package:bro/views/resource/resource_list_tile.dart';
import 'package:bro/views/widgets/contentNotAvailable.dart';
import 'package:bro/views/widgets/extract_route_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bro/utils/navigator_arguments.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late HomeBloc _homeBloc;
  late CourseListBloc _courseListBloc;
  late ResourceListBloc _resourceListBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _resourceListBloc = BlocProvider.of<ResourceListBloc>(context);
    _courseListBloc = BlocProvider.of<CourseListBloc>(context);
    _homeBloc.add(HomeRequested());
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text('Velkommen til Bro'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                var home = state.home;
                return Column(children: [
                  ListTile(title: Text(home.introduction)),
                  const SizedBox(height: 20)
                ]);
              }
              if (state is HomeLoading) {
                return LinearProgressIndicator();
              } else {
                return SizedBox(height: 170, child: ContentNotAvailable());
              }
            },
          ),
          ExpansionPanelList.radio(children: [
            ExpansionPanelRadio(
                canTapOnHeader: true,
                value: 'anbefalte_kurs',
                headerBuilder: (context, isExpanded) => ListTile(
                    title: Text('Anbefalte Kurs',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.teal))),
                body: BlocBuilder<CourseListBloc, ck.CourseListState>(
                    builder: (context, state) {
                  if (state is ck.Success) {
                    var courses = state.courses;
                    return courses.isEmpty
                        ? SizedBox(height: 170, child: ContentNotAvailable())
                        : SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                                children: courses
                                    .asMap()
                                    .keys
                                    .toList()
                                    .map((index) => GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(
                                                ExtractCourseDetailScreen
                                                    .routeName,
                                                arguments:
                                                    CourseDetailArguments(
                                                        courseGroup:
                                                            courses[index]
                                                                .courseGroup!
                                                                .slug)),
                                        child: CourseListTile(
                                          course: courses[index],
                                        )))
                                    .toList()));
                  } else {
                    return SizedBox(height: 170, child: ContentNotAvailable());
                  }
                })),
            ExpansionPanelRadio(
                canTapOnHeader: true,
                value: 'Anbefalte Ressurser',
                headerBuilder: (context, isExpanded) => ListTile(
                    title: Text('Anbefalte Ressurser',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.teal))),
                body: BlocBuilder<ResourceListBloc, ResourceListState>(
                    builder: (context, state) {
                  if (state is Success) {
                    var resources = state.resources;
                    return resources.isEmpty
                        ? SizedBox(height: 170, child: ContentNotAvailable())
                        : SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                                children: resources
                                    .asMap()
                                    .keys
                                    .toList()
                                    .map((index) => GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(
                                                ExtractResourceDetailScreen
                                                    .routeName,
                                                arguments:
                                                    ResourceDetailArguments(
                                                        group: state
                                                            .resources[index]
                                                            .resourceGroup!
                                                            .slug,
                                                        lang: 'NO')),
                                        child: ResourceListTile(
                                          cover_photo:
                                              resources[index].coverPhoto,
                                          title: resources[index].title,
                                          description:
                                              resources[index].description,
                                          resourceGroup:
                                              resources[index].resourceGroup,
                                        )))
                                    .toList()));
                  } else {
                    return SizedBox(height: 170, child: ContentNotAvailable());
                  }
                })),
          ])
        ]));
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
      _homeBloc.add(HomeRequested());
    }
  }
}
