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
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(children: [
        Column(
          children: [Text(title), Text(description)],
        ),
        //will be image
        Container(
          width: 50,
          height: 50,
          color: Colors.red,
        )
      ]),
    );
  }
}
