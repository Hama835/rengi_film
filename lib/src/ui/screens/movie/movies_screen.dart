import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/movie_list/movie_list_bloc.dart';
import '../../widgets/movies/movie_card.dart';
import '../../widgets/shimmers/movies/movie_card_shimmer.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        if (state is MovieListInitial) {
          context.read<MovieListBloc>().add(FetchingMoviesEvent());
        }
        if (state is MovieListSuccess) {
          return RefreshIndicator(
            onRefresh: () => Future.delayed(
              Duration.zero,
            ).then(
              (value) => context.read<MovieListBloc>().add(
                    RefreshMoviesListEvent(),
                  ),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Divider(),
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final data = state.movies[index];
                return MovieCard(
                  data: data,
                  isEven: index % 2 == 0,
                );
              },
            ),
          );
        } else if (state is MovieListFailed) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return const MovieListShimmer();
      },
    );
  }
}
