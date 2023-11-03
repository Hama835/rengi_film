import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rengi_filim/src/data/models/single_movie.dart';

import '../../data/repositories/remote/movie_repository.dart';
import '../../utils/resource/data_state.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailEvent>(
      eventHandler,
    );
  }

  final repository = MovieRepository();

  Future<void> fetchMovieDetails(Emitter<MovieDetailState> emit, int id) async {
    emit(MovieDetailFetching());
    final movieDetailResponse = await repository.fetchMovieDetails(id);
    if (movieDetailResponse is DataSuccess) {
      emit(MovieDetailSuccess(movieDetailResponse.data));
    } else if (movieDetailResponse is DataFailed) {
      emit(MovieDetailFailed(movieDetailResponse.error ?? "error"));
    } else {
      emit(MovieDetailFailed("error"));
    }
  }

  void eventHandler(
      MovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    if (event is FetchingMovieDetailEvent) {
      await fetchMovieDetails(emit, event.movieId);
    }
  }
}
