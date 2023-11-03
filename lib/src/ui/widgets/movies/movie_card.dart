import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:ui' as ui;

import '../../../bloc/movie_detail/movie_detail_bloc.dart';
import '../../../config/color/light_colors.dart';
import '../../../data/models/movie_list.dart';
import '../../../utils/constants/end_points.dart';
import 'tag_card.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.data, this.isEven = false});

  final MovieData data;
  final bool isEven;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MovieDetailBloc>().add(
              FetchingMovieDetailEvent(data.id!),
            );
        Navigator.pushNamed(context, '/detail', arguments: data);
      },
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            if (isEven) ...[
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
                width: 16,
              ),
            ],
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
                    Row(
                      children: [
                        Icon(
                          Iconsax.star1,
                          size: 12,
                          color: LightColors.yellow,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${data.voteAverage?.toStringAsFixed(1)}/10 IMDb",
                          textDirection: ui.TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).hintColor),
                        ),
                      ],
                    ),
                    Text(
                      data.overview ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: [
                        TagCard(
                          text: data.releaseDate ?? '',
                          icon: Iconsax.calendar_25,
                        ),
                        TagCard(
                          text: (data.popularity ?? '').toString(),
                          icon: Iconsax.people5,
                        ),
                        TagCard(
                          text: (data.originalLanguage ?? '').toString(),
                          icon: Iconsax.language_circle5,
                        )
                      ],
                    )
                  ],
                )),
            if (!isEven) ...[
              const SizedBox(
                width: 16,
              ),
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
            ],
          ],
        ),
      ),
    );
  }
}
