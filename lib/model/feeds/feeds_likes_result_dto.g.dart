// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds_likes_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikesResultDto _$LikesResultDtoFromJson(Map<String, dynamic> json) =>
    LikesResultDto(
      result: json['result'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : LikesReturnDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LikesResultDtoToJson(LikesResultDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

LikesDto _$LikesDtoFromJson(Map<String, dynamic> json) => LikesDto(
      media_id: json['media_id'] as int?,
      article_id: json['article_id'] as int?,
      behavior_type: json['behavior_type'] as String?,
      user_id: json['user_id'] as String?,
      id: json['id'] as int?,
      like: json['like'] as int?,
    );

Map<String, dynamic> _$LikesDtoToJson(LikesDto instance) => <String, dynamic>{
      'media_id': instance.media_id,
      'article_id': instance.article_id,
      'behavior_type': instance.behavior_type,
      'user_id': instance.user_id,
      'id': instance.id,
      'like': instance.like,
    };

LikesReturnDto _$LikesReturnDtoFromJson(Map<String, dynamic> json) =>
    LikesReturnDto(
      media_id: json['media_id'] as int?,
      behavior_type: json['behavior_type'] as String?,
      user_id: json['user_id'] as String?,
      id: json['id'] as int?,
      like: json['like'] as int?,
    );

Map<String, dynamic> _$LikesReturnDtoToJson(LikesReturnDto instance) =>
    <String, dynamic>{
      'media_id': instance.media_id,
      'behavior_type': instance.behavior_type,
      'user_id': instance.user_id,
      'id': instance.id,
      'like': instance.like,
    };
