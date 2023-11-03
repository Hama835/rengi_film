part of 'favorites_bloc.dart';

sealed class FavoritesEvent {}

class FetchingFavoritesEvent extends FavoritesEvent {}

class FetchingFavoritesSuccessEvent extends FavoritesEvent {}

class FetchingFavoritesFailedEvent extends FavoritesEvent {}

class InsertFavoriteEvent extends FavoritesEvent {
  final MovieData movie;
  InsertFavoriteEvent({required this.movie});
}

class DeleteFavoriteEvent extends FavoritesEvent {
  final MovieData movie;
  DeleteFavoriteEvent({required this.movie});
}
