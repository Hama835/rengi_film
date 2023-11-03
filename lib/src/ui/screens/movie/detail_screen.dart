import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rengi_filim/src/bloc/favorites/favorites_bloc.dart';
import 'package:rengi_filim/src/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:rengi_filim/src/config/color/light_colors.dart';
import 'package:rengi_filim/src/data/models/movie_list.dart';
import 'package:rengi_filim/src/data/models/single_movie.dart';
import 'package:rengi_filim/src/ui/widgets/movies/tag_card.dart';
import 'package:rengi_filim/src/ui/widgets/shimmers/movies/movie_details_shimmer.dart';
import 'package:rengi_filim/src/utils/constants/end_points.dart';
import 'package:rengi_filim/src/utils/constants/lang_keys.dart';
import 'package:rengi_filim/src/utils/extension/single_movie.dart';

import '../../../utils/extension/list.dart';
import '../../widgets/app_bar/strechable_app_bar.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.movie});

  final MovieData movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          DetailHeader(movie: movie),
          SliverToBoxAdapter(
            child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
                builder: (context, state) {
              if (state is MovieDetailSuccess) {
                final data = state.singleMovie;
                return DetailBody(data: data);
              } else if (state is MovieDetailFailed) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }

              return const MovieDetailsShimmer();
            }),
          )
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    super.key,
    required this.data,
  });

  final SingleMovie data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favoriteState) {
                  if (favoriteState is FavoritesFetchingSuccess) {
                    bool isFavored = favoriteState.favorites.findById(data.id!);
                    return IconButton(
                      onPressed: () {
                        if (isFavored) {
                          context.read<FavoritesBloc>().add(
                                DeleteFavoriteEvent(
                                    movie: data.castToMovieData()),
                              );
                        } else {
                          context.read<FavoritesBloc>().add(
                                InsertFavoriteEvent(
                                    movie: data.castToMovieData()),
                              );
                        }
                      },
                      icon: Icon(
                        isFavored ? Iconsax.heart5 : Iconsax.heart,
                        size: 28,
                        color: isFavored
                            ? LightColors.red
                            : Theme.of(context).primaryColor,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
          const SizedBox(
            height: 8,
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
          const SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              data.genres?.length ?? 0,
              (index) => TagCard(text: data.genres![index].name ?? ''),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            LangKey.description.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            data.overview ?? "",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            LangKey.productionCompanies.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            children:
                List.generate(data.productionCountries?.length ?? 0, (index) {
              ProductionCompanies company = data.productionCompanies![index];
              return company.logoPath != null
                  ? Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 2, color: LightColors.mutedPurple),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: KEndpoint.cdn + (company.logoPath ?? ''),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    )
                  : const SizedBox();
            }),
          )
        ],
      ),
    );
  }
}

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.movie,
  });

  final MovieData movie;

  @override
  Widget build(BuildContext context) {
    return StretchableAppBar(
      stretchModes: const [
        StretchMode.blurBackground,
        StretchMode.zoomBackground
      ],
      expandedHeight: 400,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: LightColors.white.withOpacity(0.5),
              shape: BoxShape.circle),
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      background: Hero(
        tag: movie.id ?? "movie_image_tag",
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(
                KEndpoint.cdn + (movie.posterPath ?? ''),
              ),
            ),
          ),
          width: double.infinity,
        ),
      ),
    );
  }
}
