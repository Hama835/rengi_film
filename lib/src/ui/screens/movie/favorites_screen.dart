import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/favorites/favorites_bloc.dart';
import '../../widgets/favorites/favorite_card.dart';
import '../../widgets/shimmers/movies/movie_card_shimmer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    context.read<FavoritesBloc>().add(FetchingFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesFetchingSuccess) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Divider(),
            ),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final data = state.favorites[index];
              return FavoriteCard(
                data: data,
              );
            },
          );
        } else if (state is FavoritesFetchingFailed) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return const MovieListShimmer();
      },
    );
  }
}
