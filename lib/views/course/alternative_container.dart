import 'package:bro/blocs/course_detail/course_detail_bloc.dart';
import 'package:bro/blocs/course_detail/course_detail_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bro/views/course/alternative.dart' as alt;
import 'package:flutter_bloc/flutter_bloc.dart';

class AlternativeContainer extends StatefulWidget {
  AlternativeContainer({
    Key key,
    this.alternatives,
    this.name,
    this.isAnswer,
    this.answerId,
  }) : super(key: key);
  final List alternatives;
  final String name;
  bool isAnswer;
  int answerId;
  @override
  _AlternativeContainerState createState() => _AlternativeContainerState();
}

class _AlternativeContainerState extends State<AlternativeContainer> {
  @override
  Widget build(BuildContext context) {
    //print(widget.question['question']);
    return Column(children: [
      Expanded(
        child: GridView.count(
          //2 columns
          crossAxisCount: 2,
          children: List.generate(widget.alternatives.length, (index) {
            return /* Center(child: Text(widget.alternatives[index]['name']) */
                alt.Alternative(
                    index,
                    widget.alternatives[index]['name'],
                    widget.alternatives[index]['correct'],
                    widget.alternatives[index]['image']);
          }),
        ),
      ),
      GestureDetector(
          onTap: () => {
                /* BlocProvider.of<CourseDetailBloc>(context)
                    .add(QuizRequested(is_answer: true, answer_id: )) */
              },
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Container(
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
