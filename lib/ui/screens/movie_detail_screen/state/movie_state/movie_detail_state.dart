import 'package:tmdb_flutter/core/network/response_models/individual_movie_detail_response.dart';

class MovieDetailState {

  IndividualMovieDetailResponse individualMovieDetailResponse;
  bool isLoading = true;

  MovieDetailState({required this.individualMovieDetailResponse, this.isLoading = true,});

  MovieDetailState copyWith({IndividualMovieDetailResponse? individualMovieDetailResponse, bool? isLoading = true,  }) {
    return MovieDetailState(
      individualMovieDetailResponse: individualMovieDetailResponse ?? this.individualMovieDetailResponse,
      isLoading: isLoading ?? false ,
    );
  }
}