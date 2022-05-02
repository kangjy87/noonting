import 'package:get/get.dart';

import '../model/feeds/feeds_item_dto.dart';
import '../model/media_info.dart';
import 'config.dart';
import 'enums.dart';

class ContentsUtil {
  /** 표시될 이미지 주소 파싱 */
  static MediaInfo getFeedsThumbNailInfo (FeedsItemDto targetItem) {
    MediaInfo _mediaInfo = MediaInfo();

    _mediaInfo.width = (Get.width - (Constants.feed_tab_horizontal_padding * 2)) * 0.5;
    _mediaInfo.height = _mediaInfo.width;

    _mediaInfo.url = targetItem.storage_thumbnail_url != null && targetItem.storage_thumbnail_url!.isNotEmpty
        ? Constants.CDN_URL + targetItem.storage_thumbnail_url!
        : "";
    if (targetItem.thumbnail_width == null || targetItem.thumbnail_height == null) {

      switch (enumFromString(PlatformType.values, targetItem.platform!)) {

        case PlatformType.instagram :
          _mediaInfo.height = _mediaInfo.height = _mediaInfo.width;
          break;
        case PlatformType.googlenews :
          _mediaInfo.height = _mediaInfo.height = _mediaInfo.width;
          break;
        case PlatformType.youtube :
        ///유튜브는 별도로 가로세로 비율을 고정해달라는 요청
          _mediaInfo.height = _mediaInfo.width! * (3/4);
          break;

        default :
          _mediaInfo.height = _mediaInfo.width! * 1.414;

      }
    } else {
      _mediaInfo.height = _mediaInfo.height = targetItem.thumbnail_height!.toDouble() * (_mediaInfo.width! / targetItem.thumbnail_width!.toDouble());
      // print('>쓰발???>>>>>>>>>${_mediaInfo.height}>>>>>>>>>>>${targetItem.thumbnail_height}');
    }

    _mediaInfo.type = MediaPlayType.image_show;

    return _mediaInfo;
  }

  /** 상세화면에 표시될 미디어 정보 */
  static MediaInfo getFeedDetailMediaInfo (ArticleMediaItemDto targetItem, PlatformType platform) {
    MediaInfo _mediaInfo = MediaInfo();
    MediaType mType = enumFromString(MediaType.values, targetItem.type!);

    if (mType == MediaType.image) {

      _mediaInfo.url =  targetItem.storage_url != null && targetItem.storage_url!.isNotEmpty
          ? Constants.CDN_URL + targetItem.storage_url!
          : "";
      _mediaInfo.type = MediaPlayType.image_show;

    } else if (mType == MediaType.video && targetItem.url!.contains("youtu")) { //--> video youtube

      _mediaInfo.url = (targetItem.url!.startsWith("https://youtu.be")) ? targetItem.url!.split("/")[3] : targetItem.url!.split('=')[1];
      _mediaInfo.type = MediaPlayType.video_youtube;

    } else if (mType == MediaType.video) { //--> video mp4

      _mediaInfo.url = (targetItem.url!.startsWith("http")) ? targetItem.url : (targetItem.url!.isNotEmpty) ? Constants.CDN_URL + targetItem.url! :
      (targetItem.storage_url!.startsWith("http")) ? targetItem.storage_url : Constants.CDN_URL + targetItem.storage_url!;
      _mediaInfo.type = MediaPlayType.video_mp4;

    }  else {
      //not yet;
    }
    //가로, 세로 NULL들어올거에 대한 처리
    if(targetItem.width != null){
      _mediaInfo.width = targetItem.width!.toDouble();
    }else{
      _mediaInfo.width = 1080;
    }
    if(targetItem.height != null){
      _mediaInfo.height = targetItem.height!.toDouble();
    }else{
      _mediaInfo.height = 1080;
    }
    return _mediaInfo;
  }

}