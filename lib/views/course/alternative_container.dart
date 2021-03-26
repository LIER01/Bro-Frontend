import 'package:bro/blocs/course_detail/course_detail_bloc.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/blocs/course_detail/course_detail_event.dart';
import 'package:bro/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bro/views/course/alternative.dart' as alt;
import 'package:flutter_bloc/flutter_bloc.dart';

class AlternativeContainer extends StatefulWidget {
  AlternativeContainer({
    Key key,
    this.course,
    this.alternatives,
    this.name,
    this.isAnswer,
    this.answerId,
  }) : super(key: key);
  Course course;
  final List alternatives;
  final String name;
  bool isAnswer;
  int answerId;
  @override
  _AlternativeContainerState createState() => _AlternativeContainerState();
}

class _AlternativeContainerState extends State<AlternativeContainer> {
  bool clicked = false;
  List alts;

  @override
  Widget build(BuildContext context) {
    alts ??= widget.alternatives;

    print('WHATISITNOW: ' + alts.toString());
    return Column(children: [
      Expanded(
          child: Container(
        padding: EdgeInsets.all(50),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          //2 columns
          crossAxisCount: alts.length == 1 ? 1 : 2,
          children: List.generate(alts.length, (index) {
            return /* Center(child: Text(widget.alternatives[index]['name']) */
                Container(
                    width: 10,
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 4),
                    child: alt.Alternative(index, alts[index]['name'],
                        alts[index]['correct'], alts[index]['image'], clicked));
          }),
        ),
      )),
      GestureDetector(
          onTap: () => {
                setState(() => alts = alts.sublist(0, 1)),
                debugPrint('CLICKCLICK: ' + alts.toString()),

                /* BlocProvider.of<CourseDetailBloc>(context).add(
                    CourseDetailRequested(
                        course: widget.course,
                        isAnswer: true,
                        answerId: 1,
                        isQuiz: true)) */
              },
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.amber),
                    width: 100,
                    height: 100,
                  )))),
    ]);
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: GridView.count(
//             crossAxisCount: 2,
//             childAspectRatio: 1,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//             children: List.generate(list.length, (index) {
//               return Alter.Alternative(
//                   index, list[index]['name'], list[index]['correct'], null);
//             })));
//   }
// }
