
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_flutter/core/network/response_models/individual_movie_detail_response.dart';
import 'package:tmdb_flutter/core/network/response_models/up_coming_movies_response.dart';
import 'package:tmdb_flutter/ui/components/loader.dart';
import 'package:tmdb_flutter/ui/screens/movie_detail_screen/provider/movie_detail_provider.dart';

class MovieDetailScreen extends ConsumerWidget {

  Results movie;
  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  // ----------------------------------------------------------
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final movieDetail = ref.watch(movieDetailProvider).individualMovieDetailResponse;
    final isLoading = ref.watch(movieDetailProvider).isLoading;

    return Scaffold(
      body: isLoading
          ? const Center(
        child: buildLoader(),
      )
          : buildMovieBody(movieDetail: movieDetail, ref: ref),
    );

    return const Placeholder();
  }

  Widget buildMovieBody({required IndividualMovieDetailResponse movieDetail, required WidgetRef ref}){
    return const SizedBox();
  }
}
