import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget ExitVerification(context, data) {
  return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.teal),
      onPressed: () => {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    titlePadding: EdgeInsets.all(2),
                    contentPadding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                    title: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        child: FaIcon(FontAwesomeIcons.solidWindowClose,
                            color: Colors.red[900], size: 22),
                        onTap: () => {
                          // We pop twice, once to remove the alertbox. Once more to pop the context
                          Navigator.of(context, rootNavigator: true).pop(),
                          Navigator.of(context).pop(),
                        },
                      ),
                    ),
                    content: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: 25),
                        child: Text('Avbryt kurs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22)),
                      ),
                      Text(
                        'Er du sikker på at du vil avbryte kurset?\n\nVed å gjøre dette lagres ikke progresjonen din.',
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          child: Text(
                            '        Avbryt Kurs        ',
                          ),
                          onPressed: () => {
                            // We pop twice, once to remove the alertbox. Once more to pop the context
                            Navigator.of(context, rootNavigator: true).pop(),
                            Navigator.of(context).pop(),
                          },
                        ),
                      ),
                    ]))),
          });
}
