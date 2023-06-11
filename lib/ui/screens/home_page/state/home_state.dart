import 'package:tmdb_flutter/core/network/response_models/up_coming_movies_response.dart';

class HomeState {

  UpComingMoviesResponse upComingMoviesResponse;
  bool isLoading;
  bool showSearch;

  HomeState({required this.upComingMoviesResponse, this.isLoading = true, this.showSearch = false});

  HomeState copyWith({UpComingMoviesResponse? upComingMoviesResponse, bool? isLoading = true, bool? showSearch = false  }) {
    return HomeState(
        upComingMoviesResponse: upComingMoviesResponse ?? this.upComingMoviesResponse,
        isLoading: isLoading ?? false ,
        showSearch: showSearch ?? false,
    );
  }
}