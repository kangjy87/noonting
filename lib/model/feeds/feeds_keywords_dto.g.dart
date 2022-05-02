// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds_keywords_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedsKeywordsListDto _$FeedsKeywordsListDtoFromJson(
        Map<String, dynamic> json) =>
    FeedsKeywordsListDto(
      result: json['result'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : FeedsKeywordsDataDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedsKeywordsListDtoToJson(
        FeedsKeywordsListDto instance) =>
    <String, dynamic>{
      'result': instance.result,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

FeedsKeywordsDataDto _$FeedsKeywordsDataDtoFromJson(
        Map<String, dynamic> json) =>
    FeedsKeywordsDataDto(
      totalCount: json['totalCount'] as int?,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => KeywordsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedsKeywordsDataDtoToJson(
        FeedsKeywordsDataDto instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'keywords': instance.keywords,
    };

KeywordsDto _$KeywordsDtoFromJson(Map<String, dynamic> json) => KeywordsDto(
      id: json['id'] as int?,
      media_id: json['media_id'] as int?,
      keyword: json['keyword'] as String?,
      platform: json['platform'] as String?,
      topic: json['topic'] as String?,
      state: json['state'] as int?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$KeywordsDtoToJson(KeywordsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_id': instance.media_id,
      'keyword': instance.keyword,
      'platform': instance.platform,
      'topic': instance.topic,
      'state': instance.state,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
