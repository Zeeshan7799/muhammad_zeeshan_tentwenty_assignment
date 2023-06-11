import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter/core/constants/mv_constants.dart';
import 'package:tmdb_flutter/core/network/response_models/configuration_response_model.dart';
import 'package:tmdb_flutter/core/network/response_models/generes_response_model.dart';
import 'package:tmdb_flutter/core/repository/movies_repository.dart';
import 'package:tmdb_flutter/ui/screens/home_page/state/home_state.dart';

import '../../../../core/network/response_models/up_coming_movies_response.dart';

class HomeDataNotifier extends StateNotifier<HomeState> {
  HomeDataNotifier(this.movieRepoProvider) : super(HomeState(upComingMoviesResponse:  UpComingMoviesResponse())) {
    getUpComingMovies();
  }
  MoviesRepository movieRepoProvider;

  Future<void> getUpComingMovies() async {

    await movieRepoProvider.getUpcomingMovies().then((data) {
      state = state.copyWith(upComingMoviesResponse: data, isLoading: false);
    });
  }

  void toggleShowSearch(){
    state = state.copyWith(showSearch: !state.showSearch, isLoading: false);
  }


  void searchThisMovieList({required String query}) {

    var filteredList = state.upComingMoviesResponse.results!.where((element) => element.title!.toLowerCase().contains(query.toLowerCase())).toList();
    state = state.copyWith(upComingMoviesResponse:state.upComingMoviesResponse.copyWith(results: filteredList), showSearch: true, isLoading: false);

    if(query == ''){
      clearSearch(showSearch: true);
    }
  }


  void clearSearch({required bool showSearch}) {
    state = state.copyWith(upComingMoviesResponse: movieRepoProvider.upComingMoviesResponse, showSearch: showSearch, isLoading: false);
  }

}
