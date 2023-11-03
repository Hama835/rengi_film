part of 'favorites_bloc.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesFetching extends FavoritesState {}

final class FavoritesFetchingSuccess extends FavoritesState {
  List<MovieData> favorites;
  FavoritesFetchingSuccess(this.favorites);
}

final class FavoritesFetchingFailed extends FavoritesState {
  final String errorMessage;
  FavoritesFetchingFailed(this.errorMessage);
}

final class AddFavoriteSuccess extends FavoritesState {}

final class AddFavoriteFailed extends FavoritesState {}

final class DeleteFavoriteSuccess extends FavoritesState {}

final class DeleteFavoriteFailed extends FavoritesState {}
