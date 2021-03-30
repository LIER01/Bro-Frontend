import 'dart:developer';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/models/course.dart';
import 'package:bro/models/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository;

  HomeBloc({@required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is HomeEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Loading) {
          final result = await repository.getCourses(0, 4);

          final courses = result.data['courses'] as List<dynamic>;
          final homeResult = await repository.getHome();
          final homeData = homeResult.data;
          final listOfCourses = courses
              .map((dynamic e) => Course(
                    title: e['title'],
                    description: e['description'],
                    questions: e['questions'],
                    slides: e['slides'],
                  ))
              .toList();
          final home = Home.fromJson(homeData);
          yield Success(
              home: home, courses: listOfCourses, hasReachedMax: false);
          return;
        }

        if (currentState is Success) {
          final result =
              await repository.getCourses(currentState.courses.length, 4);
          final courses = result.data['courses'];
          yield courses.length == 0
              ? currentState.copyWith(hasReachedMax: true)
              : Success(
                  home: currentState.home,
                  courses: currentState.courses + courses,
                  hasReachedMax: false,
                );
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    }
  }
}

bool _hasReachedMax(HomeState state) => state is Success && state.hasReachedMax;