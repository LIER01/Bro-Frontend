import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/foundation.dart';
import 'queries.dart';
import 'info_card.dart';
import 'package:dots_indicator/dots_indicator.dart';

class CourseView extends StatelessWidget {
  CourseView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(getCourseQuery)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          return Scaffold(
            appBar: result.hasException
                ? AppBar(title: Text(result.exception.toString()))
                : (result.isLoading)
                    ? AppBar(title: Text('Loading'))
                    : AppBar(
                        title: Text(result.data['course']['title']),
                      ),
            body: Center(
                child: result.hasException
                    ? Text(result.exception.toString())
                    : (result.isLoading)
                        ? CircularProgressIndicator()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height * 0.7,
                            child: CardContainerView(
                              list: result.data['course']['slides'],
                              res: result,
                            ))),
          );
        });
  }
}

class CardContainerView extends StatefulWidget {
  CardContainerView({
    Key key,
    this.list,
    this.res,
  }) : super(key: key);
  final List list;
  final QueryResult res;
  @override
  _CardContainerViewState createState() => _CardContainerViewState();
}

class _CardContainerViewState extends State<CardContainerView> {
  ScrollController _controller;
  double indx = 0;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (indx != (_controller.offset / context.size.width).round()) {
        setState(() {
          indx = (_controller.offset / context.size.width).roundToDouble();
        });
      }
      print(indx);
      //SET LIMITER PÅ ANTALL UTREGNINGER?
    });
    super.initState();
  }

//ScrollController functions for swiping right and left
  void _moveRight() {
    _controller
        .animateTo(_controller.offset + context.size.width,
            curve: Curves.linear, duration: Duration(milliseconds: 200))
        .whenComplete(() => setState(() {
              indx = _controller.offset / context.size.width;
            }));
  }

  void _moveLeft() {
    _controller
        .animateTo(_controller.offset - context.size.width,
            curve: Curves.linear, duration: Duration(milliseconds: 200))
        .whenComplete(() => setState(() {
              indx = _controller.offset / context.size.width;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (context == null) {
      return Scaffold(body: Text('Context is null, yo'));
    }

    if (widget.list.isNotEmpty) {
      return Column(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
                shrinkWrap: true,
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(),
                itemCount: widget.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InfoCard(
                      title: widget.list[index]['title'],
                      description: widget.list[index]['description'],
                      image: widget.list[index]['image']);
                })),
        //Shows which page the user is on
        DotsIndicator(
            dotsCount: widget.list.length,
            position: indx.roundToDouble(),
            decorator: DotsDecorator(
                color: Colors.grey[350], activeColor: Colors.teal)),
        //Scroll buttons
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
              onTap: () => {_moveLeft()},
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_circle_down,
                        color: Colors.teal,
                        size: 72,
                      )))),
          GestureDetector(
              onTap: () => {_moveRight()},
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_circle_down,
                        color: Colors.teal,
                        size: 72,
                      )))),
        ])
      ]);
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }
}
