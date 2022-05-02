import '../model/feeds/feed_request_body.dart';
import '../model/feeds/feeds_detail_dto.dart';
import '../model/feeds/feeds_keywords_dto.dart';
import '../model/feeds/feeds_likes_result_dto.dart';
import '../model/feeds/feeds_list_dto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import '../utils/config.dart';
part 'feeds_client.g.dart';

@RestApi(baseUrl: '${Constants.Q_API_BASE_URL}')
abstract class FeedsClient {
  factory FeedsClient(Dio dio, {String baseUrl}) = _FeedsClient;


  /** 피드리스트 */
  @GET('/api/v1/articles')
  Future<FeedsListDto> getFeeds (
      @Query("media_id") int media_id,
      @Query("page") int page,
      @Query ("per_page") int per_page,
      @Header('C9') C9,
      @Query ("platform") String? platform,
      @Query ("search") String? search,
      @Query ("user_id") int? user_id
      );

  /** 피드 상세페이지 */
  @GET('/api/v1/articles/{articleId}')
  Future<FeedsDetailDto> getFeedDetail (
      @Path ('articleId') String articleId,
      @Query ("user_id") int? user_id,
      @Header('C9') C9,
      );

  /** 즐겨찾기 */
  @GET('/api/v1/favorites')
  Future<FavoriteListDto> getFavorite (
      @Query("media_id") int media_id,
      @Query("page") int page,
      @Query ("per_page") int per_page,
      @Header('C9') C9,
      @Query ("platform") String? platform,
      @Query ("search") String? search,
      @Query ("user_id") int? user_id
      );

  /** 키워드리스트 */
  @GET('/api/v1/keywords/suggestion')
  Future<FeedsKeywordsListDto> getKeywordsList (
      @Header('C9') C9,
      @Query("media_id") int media_id,
      @Query("sort") String? sort,
      @Query ("page") int? page,
      @Query ("per_page") int? per_page
      );
  /** 좋아요 */
  @POST("/api/v1/articles/{article_id}/{behavior_type}")
  Future<LikesResultDto> setLike(
      @Path ('article_id') String article_id,
      @Path ('behavior_type') String behavior_type,
      @Header('C9') C9,
      @Body() LikesDto task
      );

  /** 스코어링 데이타 보내기 */
  @POST ('/api/v1/tags/scoring')
  Future<void> postFeedScoring (
      @Body () FeedScoringDto body
      );

// @POST("/api/v1/favorites")
// Future<FavoritesResultDto> setFavorite(
//     @Header('C9') C9,
//     @Body() FavoritesDto task
//     );
//
// @POST("/api/v1/articles/{article_id}/{behavior_type}")
// Future<LikesResultDto> setLike(
//     @Path ('article_id') String article_id,
//     @Path ('behavior_type') String behavior_type,
//     @Header('C9') C9,
//     @Body() LikesDto task
//     );
//
//
// @GET('/api/v1/favorite-groups')
// Future<GetFavoriteGroup> getFavoriteGroups (
//     @Header('C9') C9,
//     @Query("media_id") int media_id,
//     @Query("user_id") String user_id,
//     @Query("page") int page,
//     @Query("per_page") int per_page,
//     @Query("search") String search,
//     );
//
// @POST('/api/v1/favorite-groups')
// Future<FeedFavoriteGroupsAddDto> addFavoriteGroups (
//     @Header('C9') C9,
//     @Body() SetAddFavoriteGroups data
//     );
//
// @GET('/api/v1/favorites')
// Future<FavoriteListDto> getFavoritesGroupDetailList (
//     @Header('C9') C9,
//     @Query ('page') int page,
//     @Query ('per_page') int per_page,
//     @Query ('group_id') String group_id,
//     @Query ('group_use') String group_use,
//     @Query ("media_id") int? media_id,
//     @Query ("user_id") String user_id,
//     );
}
