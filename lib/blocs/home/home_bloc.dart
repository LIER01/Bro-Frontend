import 'dart:async';
import 'dart:developer';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/models/courses.dart';
import 'package:bro/models/home.dart';
import 'package:bro/models/resource.dart';
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
      : super(HomeLoading()) {
    // Uses the preferredLanguageBloc, and listens for states.
    // If the state in the preferredLanguageRepository is set to "LanguageChanged",
    // then it needs to refetch a version of the courseList which is in the correct language.
    // Upon a "LanguageChanged"-event in the preferrredLanguageBloc,
    // it triggers a HomeRequested-event, which retrieves a new version of
    // the current Home with the correct language.
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged) {
        add(HomeRequested());
      }
    });
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // If the language updates, Home is re-requested to fetch Home with the new language
    if (event is HomeRequested) {
      yield await _retrieveRecommended(event, 0);
    }
  }

  /// Retrieves the Home and 3 instances of ReducedCourse and ReducedResource
  /// and deserializes them into models
  /// May either return a State of HomeSuccess containing these models or
  /// HomeFailed
  Future<HomeState> _retrieveRecommended(
      HomeRequested event, int currLength) async {
    try {
      // Sets the amount of ReducedCourses and ReducedResources to max 3
      // Also retrieves the current preferred language
      var returnLength = 3;
      var langSlug = await preferredLanguageRepository.getPreferredLangSlug();

      // Gets home data and deserializes into models
      var home = await repository.getHome();
      var returnHome = Home.fromJson(home.data!['home']);

      // Gets recommended Courses, retrieves them from json and deserializes them into models.
      var returnCourses = await repository
          .getRecommendedCourses(currLength, returnLength, langSlug)
          .then((res) {
        // Merges the two lang and non-lang lists into one list.
        var res_list = List<Map<String, dynamic>>.from(res.data!['LangCourse'])
          ..addAll(List.from(res.data!['nonLangCourse']));
        var returnCourse = LangCourseList.takeList(res_list).langCourses;
        return returnCourse;
      });
      // Gets recommended Resources, retrieves them from json and deserializes them into models.
      var resourcesQueryResult = await repository.getRecommendedLangResources(
          0, returnLength, langSlug);
      var resourcesJson = List<Map<String, dynamic>>.from(
          resourcesQueryResult.data!['LangResource']);
      var resources = ResourceList.takeList(resourcesJson).resources;
      return HomeSuccess(
          courses: returnCourses, home: returnHome, resources: resources);
    } on NetworkException catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return HomeFailed();
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return HomeFailed();
    }
  }
}
