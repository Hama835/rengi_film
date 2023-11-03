import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/movie_list.dart';
import '../../data/repositories/local/favorate_repository.dart';
import '../../utils/resource/data_state.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEvent>(eventHandler);
  }
  final repository = FavoriteRepository();

  Future<void> addFavorite(
      MovieData movie, Emitter<FavoritesState> emit) async {
    final result = await repository.addFavorite(movie);

    if (result is DataSuccess) {
      emit(AddFavoriteSuccess());
    } else {
      emit(AddFavoriteFailed());
    }
    await fetchFavorites(emit);
  }

  Future<void> fetchFavorites(Emitter<FavoritesState> emit) async {
    final result = await repository.getFavorites();
    if (result is DataSuccess) {
      emit(FavoritesFetchingSuccess(result.data!));
    } else {
      emit(FavoritesFetchingFailed(result.error!));
    }
  }

  Future<void> deleteFavorite(
      MovieData movie, Emitter<FavoritesState> emit) async {
    final result = await repository.deleteFavorite(movie);

    if (result is DataSuccess) {
      emit(DeleteFavoriteSuccess());
    } else {
      emit(DeleteFavoriteFailed());
    }
    await fetchFavorites(emit);
  }

  void eventHandler(FavoritesEvent event, Emitter<FavoritesState> emit) async {
    inspect(event);
    if (event is FetchingFavoritesEvent) {
      await fetchFavorites(emit);
    } else if (event is InsertFavoriteEvent) {
      await addFavorite(event.movie, emit);
    } else if (event is DeleteFavoriteEvent) {
      await deleteFavorite(event.movie, emit);
    }
  }
}
