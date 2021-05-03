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
/// The bloc will only return courses in the preferred language
class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseRepository repository;
  PreferredLanguageBloc preferredLanguageBloc;
  late StreamSubscription preferredLanguageSubscription;
  late PreferredLanguageRepository preferredLanguageRepository;
  late bool recommended;
  CourseListBloc(
      {required this.repository,
      required this.preferredLanguageBloc,
      recommended})
      : super(InitialCourseList()) {
    this.recommended = recommended ?? false;
    // Uses the preferredLanguageBloc, and listens for states.
    // If the state in the preferredLanguageRepository is set to "LanguageChanged",
    // then it needs to refetch a version of the courseList which is in the correct language.
    // Upon a "LanguageChanged"-event in the preferrredLanguageBloc,
    // it triggers a CourseListRefresh-event, which retrieves a new version of
    // the current courseList with the correct language.
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged) {
        add(CourseListRefresh());
      }
    });
  }

  @override
  Stream<CourseListState> mapEventToState(CourseListEvent event) async* {
    final currentState = state;
    yield CourseListLoading();
    // It creates a snapshot of the current state, as the function runs asynchronously,
    // and a state change is theoretically possible during the runtime of the code.
    if (event is CourseListRefresh) {
      // If the event is CourseListRefresh, then it needs to reset the list and retrieve it again with the new language.
      yield await _retrieveCourses(event, 0);
      return;
    }

    // If the event is CourseListRequested and it has not reached the max length, then it is an initial state.
    // It then needs to retrieve the database.
    else if (event is CourseListRequested &&
        !_listHasReachedMax(currentState)) {
      try {
        // If the current state is CourseListSuccess, then the application has scrolled to the bottom and requests more courses.
        if (currentState is CourseListSuccess) {
          final result =
              await _retrieveCourses(event, currentState.courses.length);

          // If the result returns CourseListSuccess and it is not empty, then it adds these new courses to the current state
          if (result is CourseListSuccess && currentState.courses.isNotEmpty) {
            yield CourseListSuccess(
                courses: currentState.courses + result.courses,
                hasReachedMax: false);

            return;
          } else if (result is CourseListFailed) {
            // If the request fails, then it just displays the failed state.
            yield result;
            return;
          } else {
            yield CourseListFailed();
            return;
          }
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());
        yield CourseListFailed();
        return;
      }
    } else {
      yield CourseListFailed();
      return;
    }
    yield CourseListFailed();
    return;
  }

  /// The function takes in a CourseListEvent and the current length.
  /// Following this, it uses the language
  Future<CourseListState> _retrieveCourses(
      CourseListEvent event, int curr_len) async {
    try {
      // It retrieves the preferred language.

      var langSlug = await preferredLanguageRepository.getPreferredLangSlug();

      return await repository
          .getLangCourses(langSlug, curr_len, 10, recommended)
          .then((res) {
        if (res.data!['LangCourse'].isEmpty) {
          return CourseListFailed();
        }
        // Retrieves the list of Serialized ReducedCourses from the response.

        var res_list = List<Map<String, dynamic>>.from(res.data!['LangCourse']);

        // Deserializes the response, creates models and returns a List<LangCourse>

        final returnCourse = LangCourseList.takeList(res_list).langCourses;

        return CourseListSuccess(courses: returnCourse, hasReachedMax: false);
      });
    } on NetworkException catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return CourseListFailed();
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return CourseListFailed();
    }
  }
}

/// Checks if the list has reached the bottom of the screen.
bool _listHasReachedMax(CourseListState state) =>
    state is CourseListSuccess && state.hasReachedMax;
