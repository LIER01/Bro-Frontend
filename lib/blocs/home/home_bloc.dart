import 'dart:async';
import 'dart:developer';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/models/courses.dart';
import 'package:bro/models/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Homerequested contains home, recommended courses and recommended resources.
/// Listens to changes in PreferredLanguageState and updates based on changes.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PreferredLanguageBloc preferredLanguageBloc;
  late StreamSubscription preferredLanguageSubscription;
  late PreferredLanguageRepository preferredLanguageRepository;
  HomeRepository repository;

  HomeBloc({required this.repository, required this.preferredLanguageBloc})
      : super(Loading()) {
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged || state is MutatePreferredLanguage) {
        add(HomeRequested());
      }
    });
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is HomeRequested) {
      yield await _retrieveCourses(event, 0);
    }
  }

  Future<HomeState> _retrieveCourses(HomeRequested event, int curr_len) async {
    try {
      var home = await repository.getHome();
      var returnHome = Home.fromJson(home.data!['home']);
      var returnLength = 3;
      var langSlug = await preferredLanguageRepository.getPreferredLangSlug();
      var returnCourses = await repository
          .getRecommendedCourses(langSlug, curr_len, 3)
          .then((res) {
        var res_list = List<Map<String, dynamic>>.from(res.data!['LangCourse'])
          ..addAll(List.from(res.data!['nonLangCourse']));
        var returnCourse = LangCourseList.takeList(res_list).langCourses;
        if (returnCourse.length > returnLength) {
          returnCourse = returnCourse.sublist(0, 3);
        }
        return returnCourse;
      });
      return Success(courses: returnCourses, home: returnHome);

      /*return await repository
          .getRecommendedCourses(langSlug, curr_len, 3)
          .then((res) {
        var res_list = List<Map<String, dynamic>>.from(res.data!['LangCourse'])
          ..addAll(List.from(res.data!['nonLangCourse']));
        var returnCourse = LangCourseList.takeList(res_list).langCourses;
        if (returnCourse.length > returnLength) {
          returnCourse = returnCourse.sublist(0, 3);
        }
        return Success(courses: returnCourse, home: ret_home);
      });*/

    } on NetworkException catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return Failed();
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return Failed();
    }
  }
}

bool _hasReachedMax(HomeState state) => state is Success;
