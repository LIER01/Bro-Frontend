import 'package:bro/blocs/home/home_bloc.dart';
import 'package:bro/blocs/home/home_event.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/views/course/course_list_tile.dart';
import 'package:bro/views/resource/resource_list_tile.dart';
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
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    //_homeBloc.add(HomeRequested());
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text('Velkommen til Bro'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
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
        var courses = state.courses;
        var resources = state.resources;
        return Scaffold(
            appBar: AppBar(
              title: Text(state.home.header),
            ),
            body: Column(children: [
              SingleChildScrollView(
                  child: ExpansionPanelList.radio(children: [
                ExpansionPanelRadio(
                    value: 'Intro',
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) =>
                        ListTile(title: Text('Hva er Bro?')),
                    body: Column(children: [
                      ListTile(title: Text(state.home.introduction)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Les Mer'),
                              onPressed: () {/* ... */},
                            ),
                            const SizedBox(width: 8)
                          ]),
                    ])),
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: 'anbefalte_kurs',
                    headerBuilder: (context, isExpanded) =>
                        ListTile(title: Text('Anbefalte Kurs')),
                    body: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                            children: state.resources
                                .asMap()
                                .keys
                                .toList()
                                .map((index) => GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(
                                            ExtractCourseDetailScreen.routeName,
                                            arguments: CourseDetailArguments(
                                                courseGroup: courses[index]
                                                    .courseGroup!
                                                    .slug)),
                                    child: CourseListTile(
                                      course: state.courses[index],
                                    )))
                                .toList()))),
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: 'Anbefalte Artikler',
                    headerBuilder: (context, isExpanded) =>
                        ListTile(title: Text('Anbefalte Artikler')),
                    body: SingleChildScrollView(
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
                                            arguments: ResourceDetailArguments(
                                                group: state.resources[index]
                                                    .resourceGroup!.slug,
                                                lang: 'NO')),
                                    child: ResourceListTile(
                                      cover_photo: resources[index].coverPhoto,
                                      title: resources[index].title,
                                      description: resources[index].description,
                                      resourceGroup:
                                          resources[index].resourceGroup,
                                    )))
                                .toList()))),
              ]))
            ]));
      }
      ;
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(child: Text('Det har skjedd en feil')),
      );
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
      _homeBloc.add(HomeRequested());
    }
  }
}
