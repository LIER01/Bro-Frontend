import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/views/course/course.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:flutter/material.dart';
import 'package:bro/utils/navigator_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ExtractCourseDetailScreen extends StatelessWidget {
  static const routeName = '/courseDetail';
  final GraphQLClient client;
  ExtractCourseDetailScreen({@required this.client});

  @override
  Widget build(BuildContext context) {
    final CourseDetailArguments args =
        ModalRoute.of(context).settings.arguments;

    return BlocProvider(
      create: (context) => CourseDetailBloc(
        repository: CourseRepository(
          client: client,
        ),
      ),
      child: CourseDetailView(courseId: args.courseId),
    );
  }
}

class ExtractCourseListScreen extends StatelessWidget {
  static const routeName = '/courseList';
  final GraphQLClient client;
  ExtractCourseListScreen({@required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseListBloc(
        repository: CourseRepository(
          client: client,
        ),
      ),
      child: CourseListView(),
    );
  }
}
