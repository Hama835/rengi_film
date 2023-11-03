part of 'movie_list_bloc.dart';

sealed class MovieListEvent {}

class FetchingMoviesEvent extends MovieListEvent {}

class RefreshMoviesListEvent extends MovieListEvent {}

class MoviesSuccessEvent extends MovieListEvent {}

class MoviesFailedEvent extends MovieListEvent {}
