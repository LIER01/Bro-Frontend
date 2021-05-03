import 'package:auto_direction/auto_direction.dart';
import 'package:bro/models/courses.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Public class for building tile
class CourseListTile extends StatelessWidget {
  CourseListTile({Key? key, required this.course}) : super(key: key);

  final ReducedCourse course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _CourseDescription(
              title: course.title,
              description: course.description,
              length: course.slides.length + course.questions.length,
              time: course.slides.length + course.questions.length * 2,
              category: course.category!.categoryName,
            ),
          ),
        ],
      ),
    );
  }
}

// Private class for constructing single course tile content
class _CourseDescription extends StatelessWidget {
  const _CourseDescription({
    required this.title,
    required this.description,
    required this.length,
    required this.time,
    required this.category,
  });

  final String title;
  final String description;
  final int length;
  final int? time;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoDirection(
              text: title,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                child:
                    Text(title, style: Theme.of(context).textTheme.headline6),
              ),
            ),
            AutoDirection(
              text: description,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.hashtag,
                          size: 14,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
                        Text(
                          length.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.clock,
                          size: 14,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
                        Text(
                          time.toString() + ' min',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.tag,
                          size: 14,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0)),
                        Text(
                          category,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
