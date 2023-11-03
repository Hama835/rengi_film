import 'package:rengi_filim/src/data/models/movie_list.dart';
import 'package:rengi_filim/src/utils/local_database/data_base_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../utils/resource/data_state.dart';

class FavoriteRepository {
  Future<DataState<bool>> addFavorite(MovieData movie) async {
    final db = await DatabaseHelper.instance.database;
    try {
      await db.insert(
        'movies',
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return const DataSuccess(true);
    } catch (e) {
      return const DataFailed("an error occurred!!");
    }
  }

  Future<DataState<List<MovieData>>> getFavorites() async {
    try {
      final db = await DatabaseHelper.instance.database;
      List<Map<String, dynamic>> maps = await db.query('movies');

      List<MovieData> favorites = [];
      for (var map in maps) {
        favorites.add(MovieData.fromMap(map));
      }

      return DataSuccess(favorites);
    } catch (e) {
      return const DataFailed("An error occurred while fetching favorites.");
    }
  }

  Future<DataState<bool>> deleteFavorite(MovieData movie) async {
    final db = await DatabaseHelper.instance.database;
    try {
      int rowsDeleted = await db.delete(
        'movies',
        where: 'id = ?',
        whereArgs: [movie.id],
      );

      if (rowsDeleted > 0) {
        return const DataSuccess(true);
      } else {
        return const DataFailed("Movie not found!");
      }
    } catch (e) {
      print('Error deleting movie: $e');
      return const DataFailed("An error occurred while deleting the movie.");
    }
  }
}
