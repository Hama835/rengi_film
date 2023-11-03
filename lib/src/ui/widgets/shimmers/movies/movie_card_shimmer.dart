import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key, this.isEven = false});
  final bool isEven;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          if (isEven) ...[
            Expanded(
              flex: 1,
              child: ShimmerPro.generated(
                scaffoldBackgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                child: null,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerPro.text(
                    scaffoldBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    maxLine: 4,
                  ),
                ],
              )),
          if (!isEven) ...[
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ShimmerPro.generated(
                  scaffoldBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  child: null,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class MovieListShimmer extends StatelessWidget {
  const MovieListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Divider(),
      ),
      itemCount: 4,
      itemBuilder: (context, index) => MovieCardShimmer(
        isEven: index % 2 == 0,
      ),
    );
  }
}
