import 'package:bro/blocs/home/home_bloc.dart';
import 'package:bro/blocs/home/home_event.dart';
import 'package:bro/blocs/home/home_state.dart';
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
  var readMore = true;
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
      if (state is HomeLoading) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: LinearProgressIndicator(),
        );
      }

      if (state is HomeFailed) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: Center(child: Text('Det har skjedd en feil')),
        );
      }
      if (state is HomeSuccess) {
        var courses = state.courses;
        var resources = state.resources;
        return Scaffold(
            appBar: AppBar(
              title: Text(state.home.header),
            ),
            body: ListView(children: [
              GestureDetector(
                child: Column(children: [
                  ListTile(
                      title: Text(readMore &&
                              state.home.introduction.length > 270
                          ? state.home.introduction.substring(0, 270) + '...'
                          : state.home.introduction)),
                  state.home.introduction.length > 270
                      ? Container(
                          child: Text(readMore ? 'Les mer' : 'Les mindre',
                              style: TextStyle(color: Colors.teal)),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.1))
                      : Container(),
                  const SizedBox(height: 20),
                ]),
                onTap: () => {
                  setState(() {
                    readMore = !readMore;
                  })
                },
              ),
              ExpansionPanelList.radio(children: [
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: 'anbefalte_kurs',
                    headerBuilder: (context, isExpanded) => ListTile(
                        title: Text('Anbefalte Kurs',
                            style:
                                Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.teal))),
                    body: resources.isEmpty
                        ? SizedBox(height: 170, child: ContentNotAvailable())
                        : SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                                children: state.resources
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
                                          course: state.courses[index],
                                        )))
                                    .toList()))),
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: 'Anbefalte Ressurser',
                    headerBuilder: (context, isExpanded) => ListTile(
                        title: Text('Anbefalte Ressurser',
                            style:
                                Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.teal))),
                    body: resources.isEmpty
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
                                    .toList()))),
              ])
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
