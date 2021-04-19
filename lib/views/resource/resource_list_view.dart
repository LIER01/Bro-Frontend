import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/views/widgets/bottom_loader.dart';
import 'package:bro/views/widgets/extract_route_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bro/utils/navigator_arguments.dart';

import 'resource_list_tile.dart';

class ResourceListView extends StatefulWidget {
  ResourceListView(
      {Key? key, required this.category, required this.category_id})
      : super(key: key);
  final String category;
  final String category_id;
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
    _resourceListBloc.add(
        ResourceListRequested(lang: 'NO', category_id: widget.category_id));
  }

  AppBar _buildAppBar(categoryName) {
    return AppBar(
      title: Text(categoryName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceListBloc, ResourceListState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _buildAppBar(''),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is Failed) {
          return Scaffold(
            appBar: _buildAppBar(''),
            body: Center(
              child: Text('Error'),
            ),
          );
        }

        if (state is Success) {
          resources = state.resources;
          //print(resources);
          return Scaffold(
            appBar: _buildAppBar(widget.category),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                itemCount: state.resources.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.resources.length
                      ? BottomLoader()
                      : Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: GestureDetector(
                            onTap: () => {
                              print('click'),
                              Navigator.of(context).pushNamed(
                                  ExtractResourceDetailScreen.routeName,
                                  arguments: ResourceDetailArguments(
                                      group: state
                                          .resources[index].resourceGroup!.slug,
                                      lang: state
                                          .resources[index].language!.slug))
                            },
                            child: ResourceListTile(
                              title: state.resources[index].title,
                              resourceGroup:
                                  state.resources[index].resourceGroup,
                              description: state.resources[index].description,
                              cover_photo: state.resources[index].coverPhoto,
                            ),
                          ),
                        );
                },
              ),
            ),
          );
        }

        return Scaffold(
          appBar: _buildAppBar(''),
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
      _resourceListBloc.add(
          ResourceListRequested(lang: 'NO', category_id: widget.category_id));
    }
  }
}