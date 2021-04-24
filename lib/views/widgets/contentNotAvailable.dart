import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContentNotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Spacer(),
            FaIcon(
              FontAwesomeIcons.tools,
              color: Colors.teal.shade200,
              size: 48,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: double.infinity,
                child: Text(
                  'Innholdet er ikke tilgjengelig på ditt valgte språk. Bytt språk fra innstillinger siden og prøv igjen.',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.black),
                )),
            Spacer()
          ],
        ));
  }
}
