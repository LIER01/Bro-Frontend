import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/blocs/category/category_bucket.dart';
import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/blocs/settings/settings_bloc.dart';
import 'package:bro/data/category_repository.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/data/settings_repository.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/views/resource/category_view.dart';
import 'package:bro/views/resource/resource_detail/resource_detail_view.dart';
import 'package:bro/views/resource/resource_list_view.dart';
import 'package:bro/views/resource/resource_detail/resource_web_view.dart';
import 'package:bro/views/course/course.dart';
import 'package:bro/views/course/course_list_view.dart';
import 'package:bro/views/home_view/home_view.dart';
import 'package:bro/views/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:bro/utils/navigator_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ExtractResourceDetailScreen extends StatelessWidget {
  static const routeName = '/resourceDetail';
  final GraphQLClient client;
  final PreferredLanguageBloc preferredLanguageBloc;
  ExtractResourceDetailScreen(
      {required this.client, required this.preferredLanguageBloc});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ResourceDetailArguments;

    return BlocProvider(
      create: (context) => ResourceDetailBloc(
        repository: ResourceRepository(
          client: client,
        ),
        preferredLanguageBloc: preferredLanguageBloc,
      ),
      child: ResourceDetailView(lang: args.lang, group: args.group),
    );
  }
}

class ExtractResourseDetailWebViewScreen extends StatelessWidget {
  static const routeName = '/courseDetailWebView';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ResourceDetailWebViewArguments;

    return ResourceDetailWebView(url: args.url);
  }
}

class ExtractCourseDetailScreen extends StatelessWidget {
  static const routeName = '/courseDetail';
  final GraphQLClient client;
  final PreferredLanguageBloc preferredLanguageBloc;
  ExtractCourseDetailScreen(
      {required this.client, required this.preferredLanguageBloc});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CourseDetailArguments;

    return BlocProvider(
      create: (context) => CourseDetailBloc(
          repository: CourseRepository(
            client: client,
          ),
          preferredLanguageBloc: preferredLanguageBloc),
      child: CourseDetailView(courseGroup: args.courseGroup),
    );
  }
}

class ExtractCourseListScreen extends StatelessWidget {
  static const routeName = '/courseList';
  final GraphQLClient client;
  final PreferredLanguageBloc preferredLanguageBloc;
  ExtractCourseListScreen(
      {required this.client, required this.preferredLanguageBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseListBloc(
        repository: CourseRepository(
          client: client,
        ),
        preferredLanguageBloc: preferredLanguageBloc,
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
  final PreferredLanguageBloc preferredLanguageBloc;
  ExtractResourceListScreen(
      {required this.client, required this.preferredLanguageBloc});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ResourceListArguments;
    return BlocProvider(
      create: (context) => ResourceListBloc(
        repository: ResourceRepository(
          client: client,
        ),
        preferredLanguageBloc: preferredLanguageBloc,
      ),
      child: ResourceListView(
          category: args.category, category_id: args.category_id),
    );
  }
}

class ExtractHomeScreen extends StatelessWidget {
  static const routeName = '/homeView';
  final GraphQLClient client;
  final PreferredLanguageBloc preferredLanguageBloc;
  ExtractHomeScreen(
      {required this.client, required this.preferredLanguageBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseListBloc(
            repository: CourseRepository(
              client: client,
            ),
            preferredLanguageBloc: preferredLanguageBloc,
            recommended: true,
          ),
        ),
        BlocProvider(
            create: (context) => ResourceListBloc(
                repository: ResourceRepository(
                  client: client,
                ),
                preferredLanguageBloc: preferredLanguageBloc,
                recommended: true)),
        BlocProvider(
            create: (context) => HomeBloc(
                  homeRepository: HomeRepository(
                    client: client,
                  ),
                )),
      ],
      child: HomeView(),
    );
  }
}

class ExtractSettingsScreen extends StatelessWidget {
  static const routeName = '/settingsView';
  final GraphQLClient client;
  ExtractSettingsScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(
        repository: SettingsRepository(
          client: client,
        ),
      ),
      child: SettingsView(),
    );
  }
}
