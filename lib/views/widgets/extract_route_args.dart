import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/category_repository.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/views/category/category_view.dart';
import 'package:bro/views/category/resource_list_view.dart';
import 'package:bro/views/resource_detail/resource_detail_view.dart';
import 'package:bro/views/category/category_view.dart';
import 'package:bro/views/course/course.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:bro/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:bro/utils/navigator_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ExtractResourceDetailScreen extends StatelessWidget {
  static const routeName = '/resourceDetail';
  final GraphQLClient client;
  ExtractResourceDetailScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ResourceDetailArguments;

    return BlocProvider(
      create: (context) => ResourceDetailBloc(
        repository: ResourceRepository(
          client: client,
        ),
      ),
      child: ResourceDetailView(lang: args.lang, group: args.group),
    );
  }
}

class ExtractCourseDetailScreen extends StatelessWidget {
  static const routeName = '/courseDetail';
  final GraphQLClient client;
  ExtractCourseDetailScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CourseDetailArguments;

    return BlocProvider(
      create: (context) => CourseDetailBloc(
        repository: CourseRepository(
          client: client,
        ),
      ),
      child: CourseDetailView(courseGroup: args.courseGroup),
    );
  }
}

class ExtractCourseListScreen extends StatelessWidget {
  static const routeName = '/courseList';
  final GraphQLClient client;
  ExtractCourseListScreen({required this.client});

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

class ExtractCategoryListScreen extends StatelessWidget {
  static const routeName = '/categoryList';
  final GraphQLClient client;
  ExtractCategoryListScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(
        repository: CategoryRepository(
          client: client,
        ),
      ),
      child: CategoryView(),
    );
  }
}

class ExtractResourceListScreen extends StatelessWidget {
  static const routeName = '/resourceList';
  final GraphQLClient client;

  ExtractResourceListScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ResourceListArguments;
    return BlocProvider(
      create: (context) => ResourceListBloc(
        repository: ResourceRepository(
          client: client,
        ),
      ),
      child: ResourceListView(category: args.category),
    );
  }
}

class ResourceBloc {}

class ExtractRecommendedScreen extends StatelessWidget {
  static const routeName = '/homeView';
  final GraphQLClient client;
  ExtractRecommendedScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: HomeRepository(
          client: client,
        ),
      ),
      child: HomeView(),
    );
  }
}
