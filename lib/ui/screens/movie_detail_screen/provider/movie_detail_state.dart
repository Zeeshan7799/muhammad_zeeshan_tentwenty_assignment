import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter/core/constants/mv_constants.dart';
import 'package:tmdb_flutter/core/network/response_models/configuration_response_model.dart';
import 'package:tmdb_flutter/core/network/response_models/generes_response_model.dart';
import 'package:tmdb_flutter/core/network/response_models/individual_movie_detail_response.dart';
import 'package:tmdb_flutter/core/repository/movies_repository.dart';
import 'package:tmdb_flutter/ui/screens/home_page/state/home_state.dart';
import 'package:tmdb_flutter/ui/screens/movie_detail_screen/state/movie_state/movie_detail_state.dart';

import '../../../../core/network/response_models/up_coming_movies_response.dart';

class MovieDetailNotifier extends StateNotifier<MovieDetailState> {
  MovieDetailNotifier(this.movieRepoProvider) : super(MovieDetailState(individualMovieDetailResponse:  IndividualMovieDetailResponse()));

  MoviesRepository movieRepoProvider;

  Future<void> getMovieDetail({required num id}) async {

    await movieRepoProvider.getMovieDetail(id: id).then((data) {
      state = state.copyWith(individualMovieDetailResponse: data, isLoading: false);
    });
  }


}
