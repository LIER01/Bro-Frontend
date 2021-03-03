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
    // Uses fractionalylsizedbox to set the box as a function of the width and height of the screen
    return FractionallySizedBox(
        heightFactor: 0.5,
        widthFactor: 0.9,

        // Uses Animatedcrossfade to fade between cards
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 1000),

          // Sets the first child to fade between
          firstChild: GestureDetector(
              onTap: () => {
                    print('active second'),
                    setState(() {
                      widget == false ? active = true : active = false;
                    })
                  },
              // This lets the hit detection wrap around the child. In this case, it would be the infocard itself.
              // This lets tapping the card lead to ditting the gesturedetector instead
              behavior: HitTestBehavior.deferToChild,
              // Generation of the infocard
              child: InfoCardContent(
                  title: widget.title,
                  description: widget.description,
                  image: widget.image,
                  active: true)),

          // Same as firstchild
          secondChild: GestureDetector(
              onTap: () => {
                    print('active first'),
                    setState(() {
                      active == false ? active = true : active = false;
                    })
                  },
              behavior: HitTestBehavior.deferToChild,
              child: InfoCardContent(
                  title: widget.title,
                  description: widget.description,
                  image: widget.image,
                  active: false)),
          // This lets us fade between the two cards. The when the first fades in, the second fades out.
          crossFadeState:
              active ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ));
  }
}

class InfoCardContent extends StatefulWidget {
  InfoCardContent({this.title, this.description, this.image, this.active});
  // Passes the active,title and description-parameters down to the state
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
          Expanded(
            flex: 1,
            child: Card(
                semanticContainer: false,
                // Uses antialias to avoid artifacts when overlaying the information textbox onto the image
                clipBehavior: Clip.antiAlias,
                child: Container(
                  // Defines height and width based on the size of the container context
                  height: (MediaQuery.of(context).size.height) * 0.4,
                  width: (MediaQuery.of(context).size.width) * 0.9,

                  // Adds the image in the background of the container
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage('https://bro-strapi.herokuapp.com' +
                        widget.image['url']),
                    // This says that the image should be as small as possible while still covering the size of the box
                    fit: BoxFit.cover,

                    // This says that the image should align at the top center of the container
                    alignment: Alignment.topCenter,

                    // This is the imagefilter that is applied when the image is pressed
                    colorFilter: ColorFilter.mode(
                        Color(0x2B7A78).withOpacity(widget.active ? 0.85 : 0),
                        BlendMode.srcOver),
                  )),

                  // this checks if the image is pressed, and applies an appropriate child based on if the image has been pressed or not
                  // We need exchange between two different columns, as changing the mainaxisalignment based on a boolean is not possible.
                  // Thus, we need two different widgets with different alignment, to make sure that the bottombar is aligned the bottom, and
                  // the paddingtext is aligned at the center.
                  child: widget.active == false
                      ?
                      // This is the bottom bar on top of the image
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            // Sets the bar to the bottom of the image
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Spacer(flex: 5),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // This is the background color of the bar
                                            decoration: BoxDecoration(
                                              color: const Color(0xff7c94b6),
                                            ),

                                            // This is the tile in the middle of the bar
                                            child: ListTile(
                                              title:
                                                  // this centers the text of the bar
                                                  Center(
                                                      child: Text(
                                                // Retrieves the title of the widget
                                                widget.title,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ),
                                        )
                                      ]))
                            ],
                          ))
                      : Column(
                          // Sets the alignment of the column to the center
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding to make create some whitespace with the text
                            Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  // Displays the description
                                  widget.description,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                )),
          )
        ],
      ),
    ));
  }
}
