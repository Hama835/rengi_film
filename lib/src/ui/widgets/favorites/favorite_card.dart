import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rengi_filim/src/data/models/movie_list.dart';
import 'package:rengi_filim/src/utils/constants/end_points.dart';

import '../../../bloc/favorites/favorites_bloc.dart';
import '../../../bloc/movie_detail/movie_detail_bloc.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.data});

  final MovieData data;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      dragStartBehavior: DragStartBehavior.down,
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: Icon(
          Iconsax.trash,
          size: 33,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      key: ValueKey(data.id),
      onDismissed: (direction) {
        context.read<FavoritesBloc>().add(
              DeleteFavoriteEvent(movie: data),
            );
      },
      child: InkWell(
        onTap: () {
          context.read<MovieDetailBloc>().add(
                FetchingMovieDetailEvent(data.id!),
              );
          Navigator.pushNamed(context, '/detail', arguments: data);
        },
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Hero(
                  tag: data.id ?? "movie_image_tag",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: "${KEndpoint.cdn}${data.posterPath ?? ''}",
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const SizedBox(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: OverflowBar(
                  spacing: 5,
                  overflowSpacing: 10,
                  alignment: MainAxisAlignment.center,
                  overflowAlignment: OverflowBarAlignment.start,
                  children: [
                    Text(
                      data.title ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      data.overview ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
