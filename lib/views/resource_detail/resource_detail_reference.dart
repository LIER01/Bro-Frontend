import 'package:bro/models/resource.dart';
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
          Container(
            margin: EdgeInsets.only(top: 16.0),
            alignment: Alignment.topLeft,
            child: Text(
              reference.referenceTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.teal),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            alignment: Alignment.topLeft,
            child: Text(
              reference.referenceDescription,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                debugPrint('Heisann');
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
                      Expanded(
                        child: Text(
                          reference.referenceButtonText,
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Spacer(),
                      Container(
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
