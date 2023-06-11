import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:tmdb_flutter/core/constants/mv_constants.dart';
import 'package:tmdb_flutter/core/network/response_models/configuration_response_model.dart';
import 'package:tmdb_flutter/core/network/response_models/generes_response_model.dart';
import 'package:tmdb_flutter/core/network/response_models/individual_movie_detail_response.dart';
import 'package:tmdb_flutter/core/network/response_models/up_coming_movies_response.dart';

class LocalDb {

  // Using api_cache_manager as local db for storing configurations and genres
  // Moor db can also be used by due to Time constraint I'm not using

  // Config Local Data Getter and Setter ----------------------------------------------------------

  Future<ConfigurationResponseModel> getConfigResponseFromLocalDb() async {

    var cachedData = await APICacheManager().getCacheData(MVConstants.KEY_CONFIGURATION);
    return ConfigurationResponseModel.fromJson(json.decode(cachedData.syncData));
  }

  Future<void> saveConfigResponse({required String configurationResponseModel}) async {
    await APICacheManager().addCacheData(APICacheDBModel(key: MVConstants.KEY_CONFIGURATION, syncData: configurationResponseModel));
  }

  // UpComing Local Data Getter and Setter ----------------------------------------------------------

  Future<UpComingMoviesResponse> getUpComingMovies() async {

    var cachedData = await APICacheManager().getCacheData(MVConstants.KEY_MOVIES_LIST);
    return UpComingMoviesResponse.fromJson(json.decode(cachedData.syncData));
  }

  Future<void> saveUpComingMovies({required String upComingResponse}) async {
    await APICacheManager().addCacheData(APICacheDBModel(key: MVConstants.KEY_MOVIES_LIST, syncData: upComingResponse));
  }

  // Genres Local Data Getter and Setter ----------------------------------------------------------

  Future<void> saveGenresResponse({required String genresResponse}) async {
    await APICacheManager().addCacheData(APICacheDBModel(key: MVConstants.KEY_GENRES, syncData: genresResponse));
  }

  Future<GenresResponseModel> getGenresResponse() async {

    var cachedData = await APICacheManager().getCacheData(MVConstants.KEY_GENRES);
    return GenresResponseModel.fromJson(json.decode(cachedData.syncData));
  }

  // Individual Local Data Getter and Setter ----------------------------------------------------------

  Future<IndividualMovieDetailResponse> getIndividualMovieRecord({required String uniqueKeyForIndividualMovie}) async {

    var cachedData = await APICacheManager().getCacheData(uniqueKeyForIndividualMovie);
    return IndividualMovieDetailResponse.fromJson(json.decode(cachedData.syncData));
  }

  Future<void> saveIndividualMovieRecord({required String individualMovieRecord, required String uniqueKeyForIndividualMovie }) async {
    await APICacheManager().addCacheData(APICacheDBModel(key: uniqueKeyForIndividualMovie, syncData: individualMovieRecord));
  }

  // ----------------------------------------------------------


}