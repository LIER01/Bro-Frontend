import 'package:bro/models/course.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ArticleListState extends Equatable {
  ArticleListState();

  @override
  List<Object> get props => [];
}

class Loading extends ArticleListState {}

class ListState extends ArticleListState {
  final Course course;
  final bool isQuiz;
  final bool isAnswer;
  final int? answerId;

  ListState(
      {required this.course,
      required this.isQuiz,
      required this.isAnswer,
      this.answerId})
      : assert(!isAnswer || (isAnswer && answerId != null));

  @override
  List<Object> get props => [course, isQuiz, isAnswer];
}

class Failed extends ArticleListState {
  final String err;
  Failed({required this.err});

  @override
  List<Object> get props => [err];
}
