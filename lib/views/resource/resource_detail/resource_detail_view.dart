import 'package:auto_direction/auto_direction.dart';
import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/views/resource/resource_detail/pdf_viewer.dart';
import 'package:bro/views/resource/resource_detail/resource_detail_reference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceDetailView extends StatefulWidget {
  final String lang;
  final String group;

  ResourceDetailView({Key? key, required this.lang, required this.group})
      : super(key: key);

  @override
  _ResourceDetailViewState createState() => _ResourceDetailViewState();
}

class _ResourceDetailViewState extends State<ResourceDetailView> {
  late ResourceDetailBloc _resourceDetailBloc;
  late Resources resource;

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

  AppBar _buildAppBar(String title) {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceDetailBloc, ResourceDetailState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is ResourceDetailLoading) {
          return Scaffold(
            appBar: _buildAppBar(''),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ResourceDetailFailed) {
          return Scaffold(
            appBar: _buildAppBar('Error'),
            body: Center(
              child: Text('Error'),
            ),
          );
        }

        if (state is ResourceDetailSuccess) {
          resource = state.resource;

          return Scaffold(
            appBar: _buildAppBar(resource.title),
            body: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        resource.coverPhoto.url,
                      ),
                      onError: (exception, stackTrace) {
                        Text(exception.toString());
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  alignment: Alignment.topLeft,
                  child: Text(
                    resource.category!.categoryName.toUpperCase() +
                        ' > ' +
                        resource.title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .overline!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.left,
                  ),
                ),
                AutoDirection(
                  text: resource.description,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    //alignment: Alignment.topLeft,
                    child: Text(
                      resource.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: resource.references.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ResourceDetailReference(
                          reference: resource.references[index]);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: PDFList(
                    pdfPaths: state.resource.documents,
                  ),
                )
              ],
            ),
          );
        }

        return Scaffold(
          appBar: _buildAppBar('Error'),
          body: Center(child: Text('Det har skjedd en feil')),
        );
      },
    );
  }
}
