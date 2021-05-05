import 'dart:async';
import 'package:bro/blocs/home/home_bucket.dart';
import 'package:bro/blocs/home/home_state.dart';
import 'package:bro/data/home_repository.dart';
import 'package:bro/models/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Homerequested contains home
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
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
      var home = await homeRepository.getHome();
      var returnHome = Home.fromJson(home.data!['home']);
      return HomeSuccess(home: returnHome);
    } catch (e) {
      return HomeFailed();
    }
  }
}
