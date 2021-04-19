import 'dart:async';
import 'dart:developer';

import 'package:bro/blocs/course_list/course_list_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/models/courses.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// CourseListBloc is in charge of pulling courses from the backend.
/// It listens to PreferredLanguage State and will refresh the courses when the state is changed.
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
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged || state is MutatePreferredLanguage) {
        add(CourseListRefresh());
      }
    });
  }

  @override
  Stream<CourseListState> mapEventToState(CourseListEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is CourseListRefresh) {
      yield await _retrieveCourses(event, 0);
    }
    if (event is CourseListRequested && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Success) {
          final result =
              await _retrieveCourses(event, currentState.courses.length);
          var c = currentState.courses;
          if (result is Success) var k = result.courses;
          if (result is Success && currentState.courses.isNotEmpty) {
            yield Success(
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

  /// Returns all courses in the preferredLanguage appended with courses in Norwegian.
  Future<CourseListState> _retrieveCourses(
      CourseListEvent event, int curr_len) async {
    try {
      var langSlug = await preferredLanguageRepository.getPreferredLangSlug();
      if (langSlug != 'NO') {
        return await repository
            .getLangCourses(langSlug, curr_len, 10)
            .then((res) {
          var res_list =
              List<Map<String, dynamic>>.from(res.data!['LangCourse']);
          // removes duplicates of courses that have multiple languages.
          for (final item in List.from(res.data!['nonLangCourse'])) {
            var slug = item['course_group']['slug'];
            var has_copy = false;
            for (final target in res_list) {
              if (slug == target['course_group']['slug']) {
                has_copy = true;
              }
            }
            if (!has_copy) {
              res_list.add(item);
            }
          }
          final returnCourse = LangCourseList.takeList(res_list).langCourses;
          return Success(courses: returnCourse, hasReachedMax: false);
        });
      } else if (langSlug == 'NO') {
        return await repository
            .getLangCourses(langSlug, curr_len, 10)
            .then((res) {
          var res_list =
              List<Map<String, dynamic>>.from(res.data!['LangCourse']);
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
