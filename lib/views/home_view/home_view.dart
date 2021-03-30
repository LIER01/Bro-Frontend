import 'package:bro/blocs/home/home_bloc.dart';
import 'package:bro/blocs/home/home_event.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/views/course/course_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bro/utils/navigator_arguments.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  HomeBloc _homeBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(HomeRequested());
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
        debugPrint(state.home.header);
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
                    value: 'hey',
                    headerBuilder: (context, isExpanded) =>
                        ListTile(title: Text('Anbefalte Kurs')),
                    body: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                            children: state.courses
                                .asMap()
                                .keys
                                .toList()
                                .map((index) => GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed('/courseDetail',
                                            arguments: CourseDetailArguments(
                                                courseId: index + 1)),
                                    child: CourseListTile(
                                      course: state.courses[index],
                                    )))
                                .toList()))),
                ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: 'Anbefalte Artikler',
                    headerBuilder: (context, isExpanded) => ListTile(
                        leading: null, title: Text('Anbefalte Artikler')),
                    body: Card())
              ]))
            ]));
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
      _homeBloc.add(HomeRequested());
    }
  }
}
