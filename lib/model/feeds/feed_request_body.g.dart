// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedLikeRequestBody _$FeedLikeRequestBodyFromJson(Map<String, dynamic> json) =>
    FeedLikeRequestBody(
      media_id: json['media_id'] as int?,
      user_id: json['user_id'] as String?,
    );

Map<String, dynamic> _$FeedLikeRequestBodyToJson(
        FeedLikeRequestBody instance) =>
    <String, dynamic>{
      'media_id': instance.media_id,
      'user_id': instance.user_id,
    };

FeedReportRequestBody _$FeedReportRequestBodyFromJson(
        Map<String, dynamic> json) =>
    FeedReportRequestBody(
      media_id: json['media_id'] as int?,
      user_id: json['user_id'] as String?,
      article_id: json['article_id'] as int?,
      type: json['type'] as String?,
      user_name: json['user_name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$FeedReportRequestBodyToJson(
        FeedReportRequestBody instance) =>
    <String, dynamic>{
      'media_id': instance.media_id,
      'user_id': instance.user_id,
      'article_id': instance.article_id,
      'type': instance.type,
      'user_name': instance.user_name,
      'description': instance.description,
    };

FeedScoringDto _$FeedScoringDtoFromJson(Map<String, dynamic> json) =>
    FeedScoringDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FeedHistoryInfoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedScoringDtoToJson(FeedScoringDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

FeedHistoryInfoDto _$FeedHistoryInfoDtoFromJson(Map<String, dynamic> json) =>
    FeedHistoryInfoDto(
      event: json['event'] as String?,
      user_id: json['user_id'] as String?,
      media_id: json['media_id'] as int?,
      business_tag: json['business_tag'] as String?,
    );

Map<String, dynamic> _$FeedHistoryInfoDtoToJson(FeedHistoryInfoDto instance) =>
    <String, dynamic>{
      'event': instance.event,
      'user_id': instance.user_id,
      'media_id': instance.media_id,
      'business_tag': instance.business_tag,
    };
