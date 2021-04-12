import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/views/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bro/utils/navigator_arguments.dart';

import 'resource_list_tile.dart';

class ResourceListView extends StatefulWidget {
  ResourceListView({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  _ResourceListViewState createState() => _ResourceListViewState();
}

class _ResourceListViewState extends State<ResourceListView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late ResourceListBloc _resourceListBloc;
  late List<Resources> resources;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _resourceListBloc = BlocProvider.of<ResourceListBloc>(context);
    _resourceListBloc.add(ResourceListRequested(lang: 'NO'));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Navn på kategori'),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('resourceList opened!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    return BlocBuilder<ResourceListBloc, ResourceListState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is Failed) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Center(
              child: Text('Error'),
            ),
          );
        }

        if (state is Success) {
          resources = state.resources.resources;
          //print(resources);
          return Scaffold(
            appBar: _buildAppBar(),
            body: ListView.builder(
              itemCount: state.resources.resources.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.resources.resources.length
                    ? BottomLoader()
                    : GestureDetector(
                        onTap: () => print(
                            'click') /* Navigator.of(context).pushNamed(
                            ExtractCourseDetailScreen.routeName,
                            arguments: CourseDetailArguments(
                                courseGroup:
                                    state.courses[index].courseGroup!.slug)) */
                        ,
                        child: ResourceListTile(
                          title: state.resources.resources[index].title,
                          resourceGroup:
                              state.resources.resources[index].resourceGroup,
                          description:
                              state.resources.resources[index].description,
                          cover_photo:
                              state.resources.resources[index].coverPhoto,
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
      _resourceListBloc.add(ResourceListRequested(lang: 'NO'));
    }
  }
}
