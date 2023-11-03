part of 'movie_detail_bloc.dart';

sealed class MovieDetailState {}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailFetching extends MovieDetailState {}

final class MovieDetailSuccess extends MovieDetailState {
  final SingleMovie singleMovie;
  MovieDetailSuccess(this.singleMovie);
}

final class MovieDetailFailed extends MovieDetailState {
  final String errorMessage;
  MovieDetailFailed(this.errorMessage);
}
