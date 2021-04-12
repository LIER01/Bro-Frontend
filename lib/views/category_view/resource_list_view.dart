import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/views/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bro/utils/navigator_arguments.dart';

class ResourceListView extends StatefulWidget {
  ResourceListView({Key key}) : super(key: key);

  @override
  _ResourceListViewState createState() => _ResourceListViewState();
}

class _ResourceListViewState extends State<ResourceListView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  ResourceListBloc _resourceListBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _resourceListBloc = BlocProvider.of<ResourceListBloc>(context);
    _resourceListBloc.add(ResourceListRequested());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Kurs'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceListBloc, ResourceListState>(
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
                  ? state.resources.length
                  : state.resources.length + 1,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.resources.length
                    ? BottomLoader()
                    : GestureDetector(
                        onTap: () => print(index),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.red,
                        ));
              },
            ),
          );
        }
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
      _resourceListBloc.add(ResourceListRequested());
    }
  }
}
