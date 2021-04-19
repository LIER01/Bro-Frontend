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
      constraints: BoxConstraints(maxWidth: 90),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.04, 0, 0, 10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline6,
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(description,
                          style: Theme.of(context).textTheme.bodyText2))
                ],
              ),
              Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                alignment: Alignment.topRight,
                width: MediaQuery.of(context).size.width * 0.15,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(cover_photo.url))),
              )
            ]),
      ),
    );
  }
}
