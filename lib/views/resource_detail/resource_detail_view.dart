import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceDetailView extends StatefulWidget {
  final String lang;
  final String group;

  ResourceDetailView({Key key, this.lang, this.group}) : super(key: key);

  @override
  _ResourceDetailViewState createState() => _ResourceDetailViewState();
}

class _ResourceDetailViewState extends State<ResourceDetailView> {
  ResourceDetailBloc _resourceDetailBloc;
  Resource resource;

  @override
  void initState() {
    super.initState();
    _resourceDetailBloc = BlocProvider.of<ResourceDetailBloc>(context);
    _resourceDetailBloc
        .add(ResourceDetailRequested(lang: widget.lang, group: widget.group));
  }

  @override
  void dispose() {
    super.dispose();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Ressurser'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceDetailBloc, ResourceDetailState>(
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
          resource = state.resource;

          return Scaffold(
            appBar: _buildAppBar(),
            body: Column(
              children: [
                Text(
                  resource.title,
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
          );
        }
      },
    );
  }
}
