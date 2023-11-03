import '../../data/models/movie_list.dart';
import '../../data/models/single_movie.dart';

extension SingleMovieExt on SingleMovie {
  MovieData castToMovieData() {
    return MovieData(
        id: id, title: title, overview: overview, posterPath: posterPath);
  }
}
