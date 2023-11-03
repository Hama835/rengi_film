import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class MovieDetailsShimmer extends StatelessWidget {
  const MovieDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        children: [
          ShimmerPro.text(
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            maxLine: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          ShimmerPro.text(
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            maxLine: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          ShimmerPro.text(
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            maxLine: 15,
          ),
        ],
      ),
    );
  }
}
