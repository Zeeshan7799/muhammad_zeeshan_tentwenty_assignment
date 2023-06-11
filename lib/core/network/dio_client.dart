
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_flutter/core/network/api_constants/api_constants.dart';

import 'api_constants/interceptor/dio_interceptor.dart';
import 'api_constants/interceptor/pretty_logger_interceptor.dart';

class DioClient {
  // dio instance
  final Dio _dio;


  // injecting dio instance
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = ApiUrlConstants.BaseUrl
      ..options.connectTimeout = ApiUrlConstants.connectTimeout
      ..options.receiveTimeout = ApiUrlConstants.receiveTimeout
      ..interceptors.add(DioInterceptor())
      ..options.responseType = ResponseType.json;


    if (!kReleaseMode) {
      _dio.interceptors.add(prettyDioLogger);
    }
  }


    // Get:-----------------------------------------------------------------------
    Future<Response> get(String uri, {
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
    }) async {
      try {
        final Response response = await _dio.get(
          uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
        return response;
      } catch (e) {
        rethrow;
      }
    }

    // Post:----------------------------------------------------------------------
    Future<Response> post(String uri, {
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }) async {
      try {
        final Response response = await _dio.post(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        return response;
      } catch (e) {
        rethrow;
      }
    }

    // Put:-----------------------------------------------------------------------
    Future<Response> put(String uri, {
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }) async {
      try {
        final Response response = await _dio.put(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        return response;
      } catch (e) {
        rethrow;
      }
    }

    // Delete:--------------------------------------------------------------------
    Future<Response> delete(String uri, {
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }) async {
      try {
        final Response response = await _dio.delete(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        return response;
      } catch (e) {
        rethrow;
      }
    }
  }
