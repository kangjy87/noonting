import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../model/feeds/feeds_item_dto.dart';
import '../../model/media_info.dart';
import '../../utils/config.dart';
import '../../utils/contents_util.dart';
import '../../utils/format_util.dart';
import '../../utils/utils_sized.dart';

class FeedItemView extends StatelessWidget {

  /** 아래 스타일들 나중에 따로빼자 ------------------- */
  TextStyle tStyle1 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color (0xff717171)
  );

  TextStyle tStyle2 = TextStyle(
      fontSize: 12,
      color: Color (0xff8b8b8b)
  );
  /** ------------------------------------------ */


  FeedsItemDto? dto;
  int? index;
  VoidCallback? onTap;

  FeedItemView ({
    this.dto,
    this.index,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {

    MediaInfo _mediaInfo = ContentsUtil.getFeedsThumbNailInfo(dto!);
    // print('높이>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${_mediaInfo.height}');
    List<Color> _colors = [Colors.transparent, Colors.black45];
    List<double> _stops = [0.6, 0.9];

    String? _userThumbnailURL = dto!.article_owner!.thumbnail_url;
    if (_userThumbnailURL == null || _userThumbnailURL.isEmpty) _userThumbnailURL = "";

    String strContents = '${(dto!.hashtag == null || dto!.hashtag == '')? dto!.contents! : dto!.hashtag!}';
    String strSnsImg = 'images/sns_youtube_icon.png' ;
    String? strPlatform = dto!.article_owner!.platform ;
    if(strPlatform != null){
      switch(strPlatform){
        case 'youtube' :
          strSnsImg = 'images/sns_youtube_icon.png' ;
          break ;
        case 'instagram' :
          strSnsImg = 'images/sns_instar_icon.png' ;
          break ;
        case 'google-news' :
          strSnsImg = 'images/sns_google_icon.png' ;
          break ;
        case 'naver-blog' :
          strSnsImg = 'images/sns_blog_icon.png' ;
          break ;
      }
    }
    return Container (
        child : InkWell (
            onTap: onTap,
            child: Column(
              children: [
                Stack (
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container (
                          child: Stack (
                            children: [
                              /** 썸네일 */
                              Container(
                                height: _mediaInfo.height,
                                constraints: BoxConstraints (
                                    minHeight: _mediaInfo.url!.startsWith ("http") ? _mediaInfo.height! : 0,
                                    minWidth: double.maxFinite
                                ),
                                child: _mediaInfo.url!.startsWith ("http")
                                    ? CachedNetworkImage(
                                  imageUrl: _mediaInfo.url!,
                                  cacheKey: dto!.url,
                                  cacheManager: DefaultCacheManager(),
                                  maxWidthDiskCache: 300,
                                  maxHeightDiskCache: 300,
                                  memCacheWidth: 300,
                                  memCacheHeight: 300,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Container(
                                    height: _mediaInfo.height,
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      Images.img_no_thumbnail,
                                      height: _mediaInfo.height,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : Container(
                                  child: Image.asset(
                                    Images.img_no_thumbnail,
                                    height: _mediaInfo.height,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              /** 그라데이션 커버 */
                              if (_mediaInfo.url!.isNotEmpty)
                                Container (
                                  height: _mediaInfo.height,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: _colors,
                                        stops: _stops,
                                      )
                                  ),
                                ),
                              /** 북마크**/
                              // Positioned(
                              //   right: getUiSize (6.3),
                              //   top: getUiSize (6.3),
                              //   child: Image.asset(dto!.is_favorite == false ? AppIcons.book_makr_off : AppIcons.book_makr_on, height: getUiSize(15.5),width: getUiSize(15.5),),
                              // ),
                              /** 플랫폼 아이콘**/
                              Positioned(
                                left: getUiSize (6.3),
                                top: getUiSize (6.3),
                                child: Image.asset(strSnsImg, height: getUiSize(15.5),width: getUiSize(15.5),),
                              ),
                              // Positioned(
                              //   left: getUiSize (6.3),
                              //   bottom: getUiSize (6.3),
                              //   child: Image.asset(strSnsImg, height: getUiSize(15.5),width: getUiSize(15.5),),
                              // ),
                              Positioned(
                                right: getUiSize (6.3),
                                bottom: getUiSize (6.3),
                                child:
                                Row (
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: getUiSize (5),),
                                    Image.asset(AppIcons.ic_heart2, height: getUiSize(10.2),width: getUiSize(11.5),color: Colors.white,),
                                    SizedBox (width: getUiSize(2.5),),
                                    Text (
                                        FormatUtil.numberWithComma(dto!.article_detail  == null ? 0 : dto!.article_detail!.like!),
                                        style: TextStyle (
                                            color: Colors.white,
                                            //fontFamily: Font.NotoSansCJKkrRegular,
                                            fontSize: getUiSize(9)
                                        )
                                    ),
                                    SizedBox(
                                      width: 5,
                                    )

                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ],
            )
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(getUiSize(10))),
        )
    );

  }

}