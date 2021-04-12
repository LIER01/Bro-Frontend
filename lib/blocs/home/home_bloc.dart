import 'dart:developer';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/models/new_courses.dart';
import 'package:bro/models/reduced_course.dart';
import 'package:bro/models/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository;

  HomeBloc({required this.repository}) : super(Loading());

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

  Future<HomeState> _retrieveCourses(HomeRequested event, int curr_len) async {
    try {
      var home = await repository.getHome();
      var ret_home = Home.fromJson(home.data!['home']);
      return await repository
          .getRecommendedCourses(event.preferredLanguageSlug, curr_len, 4)
          .then((res) {
        var res_list = List<Map<String, dynamic>>.from(res.data!['LangCourse'])
          ..addAll(List.from(res.data!['nonLangCourse']));

        final returnCourse = LangCourseList.takeList(res_list).langCourses;

        return Success(
            courses: returnCourse, hasReachedMax: false, home: ret_home);
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
