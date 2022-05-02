import 'package:json_annotation/json_annotation.dart';

part 'feed_request_body.g.dart';

@JsonSerializable()
class FeedLikeRequestBody {

  int? media_id;
  String? user_id;

  FeedLikeRequestBody ({
    this.media_id,
    this.user_id
  });

  factory FeedLikeRequestBody.fromJson (Map<String, dynamic> json) => _$FeedLikeRequestBodyFromJson (json);
  Map<String, dynamic> toJson () => _$FeedLikeRequestBodyToJson (this);

}


@JsonSerializable()
class FeedReportRequestBody {

  int? media_id;
  String? user_id;
  int? article_id;
  String? type;
  String? user_name;
  String? description;

  FeedReportRequestBody ({
    this.media_id,
    this.user_id,
    this.article_id,
    this.type,
    this.user_name,
    this.description
  });

  factory FeedReportRequestBody.fromJson (Map<String, dynamic> json) => _$FeedReportRequestBodyFromJson (json);
  Map<String, dynamic> toJson () => _$FeedReportRequestBodyToJson (this);

}




@JsonSerializable ()
class FeedScoringDto {

  List<FeedHistoryInfoDto>? data;
  FeedScoringDto ({
    this.data
  });

  factory FeedScoringDto.fromJson (Map<String, dynamic> json) => _$FeedScoringDtoFromJson (json);
  Map<String, dynamic> toJson () => _$FeedScoringDtoToJson (this);

}


/** 피드 스코어링 데이타 전송용 객체 */
@JsonSerializable ()
class FeedHistoryInfoDto {

  String? event;
  String? user_id;
  int? media_id;
  String? business_tag;

  FeedHistoryInfoDto ({
    this.event,
    this.user_id,
    this.media_id,
    this.business_tag
  });

  factory FeedHistoryInfoDto.fromJson (Map<String, dynamic> json) => _$FeedHistoryInfoDtoFromJson (json);
  Map<String, dynamic> toJson () => _$FeedHistoryInfoDtoToJson (this);

}