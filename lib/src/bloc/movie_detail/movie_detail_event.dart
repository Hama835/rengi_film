part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent {}

class FetchingMovieDetailEvent extends MovieDetailEvent {
  final int movieId;
  FetchingMovieDetailEvent(this.movieId);
}

class MovieDetailSuccessEvent extends MovieDetailEvent {}

class MovieDetailFailedEvent extends MovieDetailEvent {}
