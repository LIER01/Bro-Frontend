import 'dart:async';
import 'dart:developer';

import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/models/new_courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseRepository repository;
  PreferredLanguageBloc preferredLanguageBloc;
  late StreamSubscription preferredLanguageSubscription;
  late PreferredLanguageRepository preferredLanguageRepository;
  CourseListBloc(
      {required this.repository, required this.preferredLanguageBloc})
      : super(Loading()) {
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((event) {
      if (event is LanguageChanged) {
        add(CourseListRequested(preferredLanguageSlug: event.newLang));
      }
    });
  }

  @override
  Stream<CourseListState> mapEventToState(CourseListEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is CourseListRequested && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Loading) {
          debugPrint('loading');
          var res = await _retrieveCourses(event, 0);
          yield res;
          return;
        }
        if (currentState is Success) {
          final result =
              await _retrieveCourses(event, currentState.courses.length);
          if (result is Success && currentState.courses.isNotEmpty) {
            yield result.courses.isEmpty
                ? currentState.copyWith(
                    hasReachedMax: true, courses: currentState.courses)
                : result.copyWith(
                    courses: currentState.courses + result.courses,
                    hasReachedMax: false);
          } else if (result is Failed) {
            yield result;
          } else {
            yield Failed();
          }
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());
        yield Failed();
      }
    }
  }

  Future<CourseListState> _retrieveCourses(
      CourseListRequested event, int curr_len) async {
    try {
      if (event.preferredLanguageSlug != 'NO') {
        log(event.preferredLanguageSlug!);
        var langSlug = await preferredLanguageRepository.getPreferredLangSlug();
        return await repository
            .getLangCourses(langSlug, curr_len, 10)
            .then((res) {
          var res_list =
              List<Map<String, dynamic>>.from(res.data!['LangCourse'])
                ..addAll(List.from(res.data!['nonLangCourse']));

          final returnCourse = LangCourseList.takeList(res_list).langCourses;
          return Success(courses: returnCourse, hasReachedMax: false);
        });
      } else if (event.preferredLanguageSlug == 'NO') {
        var langSlug = await preferredLanguageRepository.getPreferredLangSlug();
        return await repository
            .getLangCourses(langSlug, curr_len, 10)
            .then((res) {
          var res_list =
              List<Map<String, dynamic>>.from(res.data!['LangCourse'])
                ..addAll(List.from(res.data!['nonLangCourse']));
          final returnCourse = LangCourseList.takeList(res_list).langCourses;
          return Success(courses: returnCourse, hasReachedMax: false);
        });
      }
      return Failed();
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

bool _hasReachedMax(CourseListState state) =>
    state is Success && state.hasReachedMax;
