import 'package:bro/models/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResourceListTile extends StatelessWidget {
  const ResourceListTile({
    Key? key,
    required this.description,
    required this.resourceGroup,
    required this.title,
    required this.cover_photo,
  }) : super(key: key);
  final String title;
  final String description;
  final Cover_photo cover_photo;
  final Resource_group? resourceGroup;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline6,
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 4, 4, 4),
              width: 60,
              height: 80,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(cover_photo.url))),
            ),
          ],
        ),
      ),
    );
  }
}
