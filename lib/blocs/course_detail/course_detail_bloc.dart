import 'dart:async';
import 'dart:developer';

import 'package:bro/blocs/course_detail/course_detail_bucket.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/data/course_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/models/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Bloc takes in either a Course or a courseGroupSlug combined with the preferred language slug to determine the course to be used.
/// If Course is not set, then the bloc uses courseGroupSlug combined with the preferred language slug to request the course from the server.
/// If no Course is available in the preferred language, then it will return the norwegian version of the language.
class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  // Sets the repository to the inserted repository.
  CourseRepository repository;

  PreferredLanguageBloc preferredLanguageBloc;
  late StreamSubscription preferredLanguageSubscription;
  late PreferredLanguageRepository preferredLanguageRepository;

  // Initializes the bloc with the state Loading()
  CourseDetailBloc(
      {required this.repository, required this.preferredLanguageBloc})
      : super(InitialDetailList()) {
    // Uses the preferredLanguageBloc, and listens for states.
    // If the state in the preferredLanguageRepository is set to "LanguageChanged",
    // then it needs to refetch a version of the courseDetail which is in the correct language.
    // Upon a "LanguageChanged"-event in the preferrredLanguageBloc,
    // it triggers a CourseDetailRefresh-event, which retrieves a new version of
    // the current courseDetail with the correct language.
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged) {
        add(CourseDetailRefresh(preferredLang: state.preferredLang));
      }
    });
  }

  @override
  Stream<CourseDetailState> mapEventToState(CourseDetailEvent event) async* {
    if (event is CourseDetailRequested) {
      // If the event is CourseDetailRequested, it needs to do a request. Thus, it sets the state to loading.
      yield CourseDetailLoading();

      // If the course is null and the courseGroupSlug is null, then it has no way of retrieving the requested course.
      // If the isAnswer variable is true and answerId is null, then it has no way of knowing which answer to present in the alternative_container view.
      // In either case, the data set is incomplete and it yields the state of Failed.
      if ((event.course == null && event.courseGroupSlug == null) ||
          (event.isAnswer == true && event.answerId == null)) {
        yield CourseDetailFailed(err: 'Error, bad request');
        return;
      }

      try {
        // if isQuiz is false, then it may need to request a course from the server.
        if (event.isQuiz == false) {
          // if the course is null, but the courseGroupSlug is set, then it can use the courseGroupSlug to retrieve the course.
          if (event.course == null && event.courseGroupSlug != null) {
            // Retrieves current preferred Language and uses this to get course
            yield await _retrieveCourseDetail(event);
            return;
          } else if ((event.course != null)) {
            // If the course is not null, then it can just return the course instead of sending a request to the server.
            yield CourseDetailSuccess(
                course: event.course!,
                isQuiz: event.isQuiz,
                isAnswer: event.isAnswer,
                answerId: event.answerId);
            return;
          } else {
            // If the value of quiz is not defined, it yields a failure. This is due to the fact that "isQuiz"
            // is a required parameter in the "CourseDetailRequested" event, and thus any event without that defined
            // must be malicious.
            yield CourseDetailFailed(err: 'Error, bad request');
            return;
          }
        } else if (event.isQuiz == true) {
          // if the course is null, but the courseGroupSlug is set, then it can use the courseGroupSlug to retrieve the course.
          if (event.course == null && event.courseGroupSlug != null) {
            // Retrieves current preferred Language and uses this to get course
            yield await _retrieveCourseDetail(event);
            return;
          } else if (event.course != null) {
            // If the course is not null, then it can just return the course instead of sending a request to the server.
            yield CourseDetailSuccess(
                course: event.course!,
                isQuiz: event.isQuiz,
                isAnswer: event.isAnswer,
                answerId: event.answerId);
            return;
          } else {
            // if neither course or courseGroupSlug is defined, then this is an icomplete request and it returns Failed.
            yield CourseDetailFailed(err: 'Error, bad request');
            return;
          }
        } else {
          // If the value of quiz is not defined, it yields a failure. This is due to the fact that "isQuiz"
          // is a required parameter in the "CourseDetailRequested" event, and thus any event without that defined
          // must be malicious.
          yield CourseDetailFailed(err: 'Error, bad request');
          return;
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield CourseDetailFailed(err: 'Error, bad request');
        return;
      }
    } else if (event is CourseDetailRefresh) {
      // If the event is CourseDetailRefresh, then it needs to get a new instance of the current course with the correct language.
      // Gets the current state and requests a new instance of a course. By sending a request with the current slug, then it will
      // refetch the course with the correct language.

      // Gets a snapshot of the current state
      var currentState = state;

      // If the current state is detailsuccess, then the user are able to change the language. If not, it yield a failed state.
      if (currentState is CourseDetailSuccess) {
        // Adds a new event into the stream, by taking the current state and requesting a new version of the course with a new language.
        add(CourseDetailRequested(
          isQuiz: currentState.isQuiz,
          courseGroupSlug: currentState.course.courseGroup!.slug.toString(),
          isAnswer: currentState.isAnswer,
          answerId: currentState.answerId,
        ));
        return;
      } else {
        yield CourseDetailFailed(err: 'Error, bad request');
        return;
      }
    }

    yield CourseDetailFailed(err: 'Error, bad request');
    return;
  }

  /// Function for retrieving courseDetail
  /// Takes in an event of Type CourseDetailRequested and a String which is the slug of the preferred language
  /// Returns a state of type CourseDetailSuccess or CourseDetailFailed
  /// If no courseDetail is available in the preferred language, then
  Future<CourseDetailState> _retrieveCourseDetail(
      CourseDetailRequested event) async {
    try {
      return await repository
          .getCourseQuery(event.courseGroupSlug!,
              await preferredLanguageRepository.getPreferredLangSlug())
          .then((res) async {
        // getCourseQuery may return an empty queryset, if there is no version of the Course in the preferred language.
        // If that is the case, then it send another request for the Norwegian version of the course and return that instead.
        if (res.data!['courses'].isEmpty) {
          // The fallbackrequest to retrieve the fallbackCourse.
          final fallbackCourseResult =
              await repository.getCourseQuery(event.courseGroupSlug!, 'NO');

          // The json-response is deserialized into a model of type Course.
          final fallbackCourse =
              Course.fromJson(fallbackCourseResult.data!['courses'][0]);
          return CourseDetailSuccess(
              course: fallbackCourse,
              isQuiz: event.isQuiz,
              isAnswer: event.isAnswer,
              answerId: event.answerId);
        } else if (res.data!.isNotEmpty) {
          // If the queryset is not empty, then a version of the Course exists in the requested language.
          // The json-response is deserialized into a model of type Course.
          final returnCourse = Course.fromJson(res.data!['courses'][0]);

          return CourseDetailSuccess(
              course: returnCourse,
              isQuiz: event.isQuiz,
              isAnswer: event.isAnswer,
              answerId: event.answerId);
        } else {
          // If the queryset does not fit into any of the other cases, then it is an invalid state and return Failed.
          return CourseDetailFailed(err: 'Error, bad request');
        }
      });
    } on NetworkException catch (e, stackTrace) {
      // If the connection to the server failed, the user will be informed of such an error.
      log(e.toString());
      log(stackTrace.toString());
      return CourseDetailFailed(err: 'Error, failed to contact server');
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());

      return CourseDetailFailed(err: 'Error, bad request');
    }
  }
}
