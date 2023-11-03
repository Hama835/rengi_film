part of 'movie_list_bloc.dart';

sealed class MovieListState {}

final class MovieListInitial extends MovieListState {}

final class MovieListFetching extends MovieListState {}

final class MovieListSuccess extends MovieListState {
  final List<MovieData> movies;
  MovieListSuccess(this.movies);
}

final class MovieListFailed extends MovieListState {
  final String errorMessage;
  MovieListFailed(this.errorMessage);
}
