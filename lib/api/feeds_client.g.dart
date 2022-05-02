// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _FeedsClient implements FeedsClient {
  _FeedsClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://dev.api.curator9.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<FeedsListDto> getFeeds(
      media_id, page, per_page, C9, platform, search, user_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'media_id': media_id,
      r'page': page,
      r'per_page': per_page,
      r'platform': platform,
      r'search': search,
      r'user_id': user_id
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'C9': C9};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FeedsListDto>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/articles',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FeedsListDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FeedsDetailDto> getFeedDetail(articleId, user_id, C9) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': user_id};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'C9': C9};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FeedsDetailDto>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/articles/${articleId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FeedsDetailDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FavoriteListDto> getFavorite(
      media_id, page, per_page, C9, platform, search, user_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'media_id': media_id,
      r'page': page,
      r'per_page': per_page,
      r'platform': platform,
      r'search': search,
      r'user_id': user_id
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'C9': C9};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteListDto>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/favorites',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FavoriteListDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FeedsKeywordsListDto> getKeywordsList(
      C9, media_id, sort, page, per_page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'media_id': media_id,
      r'sort': sort,
      r'page': page,
      r'per_page': per_page
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'C9': C9};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FeedsKeywordsListDto>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/keywords/suggestion',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FeedsKeywordsListDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LikesResultDto> setLike(article_id, behavior_type, C9, task) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'C9': C9};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(task.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LikesResultDto>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/api/v1/articles/${article_id}/${behavior_type}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LikesResultDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> postFeedScoring(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '/api/v1/tags/scoring',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
