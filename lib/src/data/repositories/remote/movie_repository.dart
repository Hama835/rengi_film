import 'dart:convert';

import 'package:rengi_filim/src/data/models/movie_list.dart';
import 'package:rengi_filim/src/data/models/single_movie.dart';
import 'package:rengi_filim/src/utils/base_client.dart';
import 'package:rengi_filim/src/utils/constants/end_points.dart';
import 'package:rengi_filim/src/utils/resource/data_state.dart';

class MovieRepository {
  Future<DataState> fetchPopularMovies() async {
    try {
      final response = await BaseClient().get(KEndpoint.papular);
      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final parsedData = MovieList.fromJson(decodedData).results;
        return DataSuccess(parsedData);
      } else {
        return DataFailed(decodedData["status_message"]);
      }
    } catch (e) {
      return const DataNotSet();
    }
  }

  Future<DataState> fetchMovieDetails(int id) async {
    try {
      final response = await BaseClient().get('/$id');
      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final parsedData = SingleMovie.fromJson(decodedData);
        return DataSuccess(parsedData);
      } else {
        return DataFailed(decodedData["status_message"]);
      }
    } catch (e) {
      return const DataNotSet();
    }
  }
}
