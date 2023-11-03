import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rengi_filim/src/data/models/movie_list.dart';
import 'package:rengi_filim/src/data/repositories/remote/movie_repository.dart';
import 'package:rengi_filim/src/utils/resource/data_state.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(MovieListInitial()) {
    on<MovieListEvent>(
      eventHandler,
    );
  }

  final repository = MovieRepository();

  Future<void> fetchPopularMovies(Emitter<MovieListState> emit) async {
    emit(MovieListFetching());
    final movieListResponse = await repository.fetchPopularMovies();
    if (movieListResponse is DataSuccess) {
      emit(MovieListSuccess(movieListResponse.data));
    } else if (movieListResponse is DataFailed) {
      emit(MovieListFailed(movieListResponse.error ?? "error"));
    } else {
      emit(MovieListFailed("error"));
    }
  }

  void eventHandler(MovieListEvent event, Emitter<MovieListState> emit) async {
    if (event is FetchingMoviesEvent || event is RefreshMoviesListEvent) {
      try {
        await fetchPopularMovies(emit);
      } catch (e) {
        throw Exception(e);
      }
    }
  }
}
