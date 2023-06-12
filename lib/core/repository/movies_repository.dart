
import 'dart:convert';

import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdb_flutter/core/constants/mv_constants.dart';
import 'package:tmdb_flutter/core/local_db/local_db.dart';
import 'package:tmdb_flutter/core/network/api_constants/api_constants.dart';
import 'package:tmdb_flutter/core/network/dio_exceptions.dart';
import 'package:tmdb_flutter/core/network/response_models/generes_response_model.dart';
import 'package:tmdb_flutter/core/network/response_models/individual_movie_detail_response.dart';

import '../network/dio_client.dart';
import '../network/response_models/configuration_response_model.dart';
import '../network/response_models/up_coming_movies_response.dart';

class MoviesRepository {

  // dio instance
  final DioClient _dioClient;
  final LocalDb localDb;

  late ConfigurationResponseModel configurationResponseModel;
  late GenresResponseModel genresResponseModel;
  late UpComingMoviesResponse upComingMoviesResponse;

  MoviesRepository(this._dioClient, this.localDb);

  Future<UpComingMoviesResponse> getUpcomingMovies() async {

    // Check if Configuration data exist in local cache db
    // As configuration and genres are needed to be downloaded first before fetching upcoming movies list
    final isConfigDataExist = await APICacheManager().isAPICacheKeyExist(MVConstants.KEY_CONFIGURATION);
    if(!isConfigDataExist){
      await getConfigurations();
    }else{
      configurationResponseModel = await localDb.getConfigResponseFromLocalDb();

    }

    // Check if Genres data exist in local cache db
    final isGenresDataExist = await APICacheManager().isAPICacheKeyExist(MVConstants.KEY_GENRES);
    if (!isGenresDataExist) {
      await getGenres();
    }else{
      genresResponseModel = await localDb.getGenresResponse();
    }


    final isUpComingMoviesExist = await APICacheManager().isAPICacheKeyExist(MVConstants.KEY_MOVIES_LIST);
    if (!isUpComingMoviesExist) {
      try {
        final res = await _dioClient.get(ApiUrlConstants.endPointUpComingMovies);
        final response = UpComingMoviesResponse.fromJson(res.data);
        upComingMoviesResponse = response;

        //Saving in local cache db
        localDb.saveUpComingMovies(upComingResponse: json.encode(res.data));

        return response;
      } on DioException catch (e) {
        final errorMessage = DioExceptions.fromDioError(e);
        debugPrint(errorMessage.toString());
        rethrow;
      }
    }else{
      upComingMoviesResponse = await localDb.getUpComingMovies();
      return upComingMoviesResponse;
    }
  }

  Future<ConfigurationResponseModel> getConfigurations() async {

    // We Store Configuration in Local Cache
    // For the moment I'm storing in local db using package called local api_cache_manager ( also Moor can be used but due
    // to time constraint I'm not storing in Moor db

    try {
      final res = await _dioClient.get(ApiUrlConstants.endPointConfiguration);
      final configs = ConfigurationResponseModel.fromJson(res.data);
      configurationResponseModel = configs;
      //Saving in local cache db
      localDb.saveConfigResponse(configurationResponseModel: json.encode(res.data));

      return configs;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debugPrint(errorMessage.toString());
      rethrow;
    }
  }

  Future<GenresResponseModel> getGenres() async {

    // We Store Genres in Local Cache
    // For the moment I'm storing in local db using package called local api_cache_manager ( also Moor can be used but due
    // to time constraint I'm not storing in Moor db

    try {
      final res = await _dioClient.get(ApiUrlConstants.genres);
      final genres = GenresResponseModel.fromJson(res.data);
      genresResponseModel = genres;

      //Saving in local cache db
      localDb.saveGenresResponse(genresResponse: json.encode(res.data));


      return genres;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debugPrint(errorMessage.toString());
      rethrow;
    }
  }

  Future<IndividualMovieDetailResponse> getMovieDetail({required num id}) async {

    // We Store Genres in Local Cache
    // For the moment I'm storing in local db using package called local api_cache_manager ( also Moor can be used but due
    // to time constraint I'm not storing in Moor db

    final isUpComingMoviesExist = await APICacheManager().isAPICacheKeyExist(id.toString());
    if (!isUpComingMoviesExist) {
      try {
        final res = await _dioClient.get(ApiUrlConstants.individualMovie + id.toString());
        final individualMovieDetailResponse = IndividualMovieDetailResponse.fromJson(res.data);

        localDb.saveIndividualMovieRecord(individualMovieRecord: json.encode(res.data), uniqueKeyForIndividualMovie :id.toString());
        return individualMovieDetailResponse;
      } on DioException catch (e) {
        final errorMessage = DioExceptions.fromDioError(e);
        debugPrint(errorMessage.toString());
        rethrow;
      }
    }else{
        return await localDb.getIndividualMovieRecord(uniqueKeyForIndividualMovie: id.toString());
    }


  }
}