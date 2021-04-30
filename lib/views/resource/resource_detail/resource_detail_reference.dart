import 'package:auto_direction/auto_direction.dart';
import 'package:bro/models/resource.dart';
import 'package:bro/utils/navigator_arguments.dart';
import 'package:bro/views/widgets/extract_route_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResourceDetailReference extends StatelessWidget {
  ResourceDetailReference({Key? key, required this.reference})
      : super(key: key);

  final References reference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          AutoDirection(
            text: reference.referenceTitle,
            child: Container(
              margin: EdgeInsets.only(top: 16.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                reference.referenceTitle,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.teal),
              ),
            ),
          ),
          AutoDirection(
            text: reference.referenceDescription,
            child: Container(
              margin: EdgeInsets.only(top: 8.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                reference.referenceDescription,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ExtractResourseDetailWebViewScreen.routeName,
                  arguments: ResourceDetailWebViewArguments(
                      url: reference.referenceUrl),
                );
              },
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      AutoDirection(
                        text: reference.referenceButtonText,
                        child: Expanded(
                          child: Text(
                            reference.referenceButtonText,
                            style: Theme.of(context).textTheme.button!.copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: FaIcon(
                          FontAwesomeIcons.chevronRight,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
