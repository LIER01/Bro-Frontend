import 'dart:async';
import 'dart:developer';
import 'package:bro/blocs/course_list/course_list_bloc.dart';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bloc.dart';
import 'package:bro/blocs/resource_list/resource_list_bloc.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/models/courses.dart';
import 'package:bro/models/home.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Homerequested contains home, recommended courses and recommended resources.
/// Listens to changes in PreferredLanguageState and updates based on changes.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    if (event is HomeRequested) {
      yield await _retrieveCourses(event, 0);
    }
  }

  Future<HomeState> _retrieveCourses(
      HomeRequested event, int currLength) async {
    try {
      var home = await homeRepository.getHome();
      var returnHome = Home.fromJson(home.data!['home']);
      return HomeSuccess(home: returnHome);
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
