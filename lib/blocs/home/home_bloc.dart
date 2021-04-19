import 'dart:async';
import 'dart:developer';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_state.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/models/new_courses.dart';
import 'package:bro/models/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PreferredLanguageBloc preferredLanguageBloc;
  late StreamSubscription preferredLanguageSubscription;
  late PreferredLanguageRepository preferredLanguageRepository;
  HomeRepository repository;

  HomeBloc({required this.repository, required this.preferredLanguageBloc})
      : super(Loading()) {
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((event) {
      if (event is LanguageChanged || event is MutatePreferredLanguage) {
        add(HomeRequested());
      }
    });
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is HomeRequested && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Loading) {
          var res = await _retrieveCourses(event, 0);
          yield res;
          return;
        }

        if (currentState is Success) {
          final result =
              await _retrieveCourses(event, currentState.courses.length);
          yield result;
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    }
  }

  Future<HomeState> _retrieveCourses(HomeRequested event, int curr_len) async {
    try {
      var home = await repository.getHome();
      var ret_home = Home.fromJson(home.data!['home']);
      var returnLength = 3;
      var langSlug;
     /* if (event.preferredLanguageSlug == '') {
        langSlug = await preferredLanguageRepository.getPreferredLangSlug();
      } else {
        langSlug = event.preferredLanguageSlug;
      }*/
      langSlug = await preferredLanguageRepository.getPreferredLangSlug();
      return await repository
          .getRecommendedCourses(langSlug, curr_len, 3)
          .then((res) {
        var res_list = List<Map<String, dynamic>>.from(res.data!['LangCourse'])
          ..addAll(List.from(res.data!['nonLangCourse']));
        final returnCourse = LangCourseList.takeList(res_list).langCourses;
        debugPrint(returnCourse.toString());
        var rs = returnCourse;
        if (returnCourse.length > returnLength) {
          rs = returnCourse.sublist(0, 3);
        }

        return Success(courses: rs, hasReachedMax: false, home: ret_home);
      });
      // return result;
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

bool _hasReachedMax(HomeState state) => state is Success && state.hasReachedMax;
