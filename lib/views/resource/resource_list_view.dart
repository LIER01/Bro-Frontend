import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/views/widgets/bottom_loader.dart';
import 'package:bro/views/widgets/contentNotAvailable.dart';
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
  late PreferredLanguageBloc _preferredLanguageBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _resourceListBloc = BlocProvider.of<ResourceListBloc>(context);
    _resourceListBloc
        .add(ResourceListRequested(category_id: widget.category_id));
    _preferredLanguageBloc = _resourceListBloc.preferredLanguageBloc;
    _preferredLanguageBloc.add(PreferredLanguageRequested());
  }

  AppBar _buildAppBar(categoryName) {
    return AppBar(
      title: Text(categoryName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceListBloc, ResourceListState>(
      builder: (context, state) {
        debugPrint(state.toString());
        if (state is ResourceListLoading) {
          return Scaffold(
            appBar: _buildAppBar(''),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ResourceListFailed) {
          return Scaffold(
            appBar: _buildAppBar(''),
            body: Center(
              child: Text('Error'),
            ),
          );
        } else if (state is ResourceListSuccess) {
          resources = state.resources;

          return Scaffold(
            appBar: _buildAppBar(widget.category),
            body: state.resources.isEmpty
                ? ContentNotAvailable()
                : Container(
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
                                    Navigator.of(context).pushNamed(
                                        ExtractResourceDetailScreen.routeName,
                                        arguments: ResourceDetailArguments(
                                            group: state.resources[index]
                                                .resourceGroup!.slug,
                                            lang: state.resources[index]
                                                .language!.slug))
                                  },
                                  child: ResourceListTile(
                                    title: state.resources[index].title,
                                    resourceGroup:
                                        state.resources[index].resourceGroup,
                                    description:
                                        state.resources[index].description,
                                    cover_photo:
                                        state.resources[index].coverPhoto,
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
          );
        } else {
          return Scaffold(
            appBar: _buildAppBar(''),
            body: Center(child: Text('Det har skjedd en feil')),
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
      _resourceListBloc
          .add(ResourceListRequested(category_id: widget.category_id));
    }
  }
}
