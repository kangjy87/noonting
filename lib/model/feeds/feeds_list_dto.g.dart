// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedsListDto _$FeedsListDtoFromJson(Map<String, dynamic> json) => FeedsListDto(
      result: json['result'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : FeedsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedsListDtoToJson(FeedsListDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

FeedsData _$FeedsDataFromJson(Map<String, dynamic> json) => FeedsData(
      totalCount: json['totalCount'] as int?,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => FeedsItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedsDataToJson(FeedsData instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'articles': instance.articles,
    };

FeedsListRequestBody _$FeedsListRequestBodyFromJson(
        Map<String, dynamic> json) =>
    FeedsListRequestBody(
      media_idx: json['media_idx'] as int?,
      page: json['page'] as int?,
      per_page: json['per_page'] as int?,
    );

Map<String, dynamic> _$FeedsListRequestBodyToJson(
        FeedsListRequestBody instance) =>
    <String, dynamic>{
      'media_idx': instance.media_idx,
      'page': instance.page,
      'per_page': instance.per_page,
    };

FavoriteListDto _$FavoriteListDtoFromJson(Map<String, dynamic> json) =>
    FavoriteListDto(
      result: json['result'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : FavoriteData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteListDtoToJson(FavoriteListDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

FavoriteData _$FavoriteDataFromJson(Map<String, dynamic> json) => FavoriteData(
      totalCount: json['totalCount'] as int?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => FavoriteItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteDataToJson(FavoriteData instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'favorites': instance.favorites,
    };

FavoriteItemDto _$FavoriteItemDtoFromJson(Map<String, dynamic> json) =>
    FavoriteItemDto(
      id: json['id'] as int?,
      media_id: json['media_id'] as int?,
      user_id: json['user_id'] as String?,
      article_id: json['article_id'] as int?,
      group_id: json['group_id'] as int?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      is_like: json['is_like'] as bool?,
      favorite_group: json['favorite_group'] == null
          ? null
          : FavoriteGroup.fromJson(
              json['favorite_group'] as Map<String, dynamic>),
      article: json['article'] == null
          ? null
          : FeedsItemDto.fromJson(json['article'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteItemDtoToJson(FavoriteItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_id': instance.media_id,
      'user_id': instance.user_id,
      'article_id': instance.article_id,
      'group_id': instance.group_id,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'is_like': instance.is_like,
      'favorite_group': instance.favorite_group,
      'article': instance.article,
    };

FavoriteGroup _$FavoriteGroupFromJson(Map<String, dynamic> json) =>
    FavoriteGroup(
      id: json['id'] as int?,
      media_id: json['media_id'] as int?,
      user_id: json['user_id'] as String?,
      group_name: json['group_name'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$FavoriteGroupToJson(FavoriteGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_id': instance.media_id,
      'user_id': instance.user_id,
      'group_name': instance.group_name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
