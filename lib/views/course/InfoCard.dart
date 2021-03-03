import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../assets/globals.dart' as globals;

class InfoCard extends StatefulWidget {
  InfoCard({Key key, this.title, this.description, this.image})
      : super(key: key);
  String title;
  String description;
  LinkedHashMap<String, dynamic> image;
  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return
        //Crossfades between InfoCardContent with active true and false. Activate is used to decide what content is shown
        AnimatedCrossFade(
      duration: const Duration(milliseconds: 1000),
      //GestureDetectors changes card to active if not active and vice versa
      firstChild: Container(
          constraints: BoxConstraints(
              maxHeight: 1000, maxWidth: MediaQuery.of(context).size.width),
          child: GestureDetector(
              onTap: () => {
                    setState(() {
                      active == false ? active = true : active = false;
                    })
                  },
              //Makes the GestureDetector click area within the bounds of the child
              behavior: HitTestBehavior.deferToChild,
              child: InfoCardContent(
                  title: widget.title,
                  description: widget.description,
                  image: widget.image,
                  active: true))),
      secondChild: Container(
          constraints: BoxConstraints(
              maxHeight: 1000, maxWidth: MediaQuery.of(context).size.width),
          child: GestureDetector(
              onTap: () => {
                    setState(() {
                      active == false ? active = true : active = false;
                    })
                  },
              behavior: HitTestBehavior.deferToChild,
              child: InfoCardContent(
                  title: widget.title,
                  description: widget.description,
                  image: widget.image,
                  active: false))),
      crossFadeState:
          active ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}

//Child widget made so that two versions can be used by animatedCrossFade
class InfoCardContent extends StatefulWidget {
  InfoCardContent({this.title, this.description, this.image, this.active});
  bool active;
  String title;
  String description;
  LinkedHashMap<String, dynamic> image;

  @override
  _InfoCardContentState createState() => _InfoCardContentState();
}

class _InfoCardContentState extends State<InfoCardContent> {
  double opaque = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.image['url']);
    return Scaffold(
        body: Center(
      //Allows for animated color transition when card is clicked
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              semanticContainer: false,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'https://bro-strapi.herokuapp.com' + widget.image['url']),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                      Color(0x2B7A78).withOpacity(widget.active ? 0.85 : 0),
                      BlendMode.srcOver),
                )),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Testslide', //widget.title,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.description,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: globals.primaryColor),
                          onPressed: () {
                            // Perform some action
                          },
                          child: const Text('<-'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            // Perform some action
                          },
                          child: const Text('->'),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
