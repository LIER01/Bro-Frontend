import 'dart:collection';
import 'package:bro/models/new_course.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bro/models/course.dart';

class InfoCard extends StatefulWidget {
  InfoCard(
      {Key? key, required this.title, required this.description, this.image})
      : super(key: key);
  final String title;
  final String description;
  final Media? image;
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
      duration: const Duration(milliseconds: 500),
      //GestureDetectors changes card to active if not active and vice versa
      firstChild: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              maxWidth: MediaQuery.of(context).size.width),
          child: GestureDetector(
              onTap: () => {
                    setState(() {
                      active == false ? active = true : active = false;
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
                  active: true))),
      secondChild: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              maxWidth: MediaQuery.of(context).size.width),
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
  InfoCardContent(
      {required this.title,
      required this.description,
      this.image,
      required this.active});
  // Passes the active,title and description-parameters down to the state
  final bool active;
  final String title;
  final String description;
  final Media? image;

  @override
  _InfoCardContentState createState() => _InfoCardContentState();
}

class _InfoCardContentState extends State<InfoCardContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      //Allows for animated color transition when card is clicked
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: widget.image == null || widget.image!.url == null
                  ? CachedNetworkImage(
                      imageUrl: 'https://bro-strapi.herokuapp.com' +
                          widget.image!.url,
                      imageBuilder: (context, imageProvider) =>
                          _generateInfoCard(
                              widget.active,
                              widget.title,
                              widget.description,
                              widget.image,
                              context,
                              imageProvider),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/placeholder.png'),
                    )
                  : _generateInfoCard(
                      widget.active,
                      widget.title,
                      widget.description,
                      widget.image,
                      context,
                      AssetImage('assets/images/placeholder.png')))
        ],
      ),
    ));
  }

  Widget _generateInfoCard(bool active, String title, String description,
      Media? image, BuildContext context, ImageProvider imageProvider) {
    return Card(
        semanticContainer: false,
        // Uses antialias to avoid artifacts when overlaying the information textbox onto the image
        clipBehavior: Clip.antiAlias,
        child: Container(
          // Defines height and width based on the size of the container context
          width: (MediaQuery.of(context).size.width) * 0.9,

          // Adds the image in the background of the container
          decoration: BoxDecoration(
              image: DecorationImage(
            image: imageProvider,
            // This says that the image should be as small as possible while still covering the size of the box
            fit: BoxFit.cover,

            // This says that the image should align at the top center of the container
            alignment: Alignment.topCenter,

            // This is the imagefilter that is applied when the image is pressed
            colorFilter: ColorFilter.mode(
                Colors.teal.withOpacity(active ? 0.85 : 0), BlendMode.srcOver),
          )),

          // this checks if the image is pressed, and applies an appropriate child based on if the image has been pressed or not
          // We need exchange between two different columns, as changing the mainaxisalignment based on a boolean is not possible.
          // Thus, we need two different widgets with different alignment, to make sure that the bottombar is aligned the bottom, and
          // the paddingtext is aligned at the center.
          child: active == false
              ?
              // This is the bottom bar on top of the image
              Column(
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
                                    color: Colors.teal,
                                  ),

                                  // This is the tile in the middle of the bar
                                  child: ListTile(
                                    title:
                                        // this centers the text of the bar
                                        Center(
                                            child: Text(
                                      // Retrieves the title of the widget
                                      title,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              )
                            ]))
                  ],
                )
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
                          description,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
        ));
  }
}
