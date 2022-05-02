import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:noonting/ui/feed/tdi_vide_player.dart';
import 'package:noonting/ui/feed/tdi_youtube_player.dart';

import '../../controller/feed_detail_controller.dart';
import '../../model/feeds/feeds_item_dto.dart';
import '../../model/media_info.dart';
import '../../utils/config.dart';
import '../../utils/contents_util.dart';
import '../../utils/enums.dart';
import '../../utils/logger_utils.dart';
import '../../utils/utils_sized.dart';

class MediaItemView extends StatelessWidget {
  String strControllerTag ;
  TdiYouTubePlayer? youTubePlayer ;
  BuildContext? mediaContext ;
  MediaItemView({
    required this.strControllerTag
  });
  Widget _commonError = Container (
      color: Colors.grey,
      child: Image.asset(Images.img_placeholder, fit: BoxFit.cover,)
  );

  Widget _getMediaItemView (ArticleMediaItemDto item, PlatformType platform) {
    MediaInfo _mediaInfo = ContentsUtil.getFeedDetailMediaInfo (item, platform);

    switch (enumFromString(MediaType.values, item.type!)) {
      case MediaType.image :
        String? _mediaUrl = (item.storage_url!.startsWith("http")) ? item.storage_url : Constants.CDN_URL + item.storage_url!;
        customLogger.d("_mediaUrl -- $_mediaUrl");
        return Container(
          width: Get.width,
          height: item.height?.toDouble(),
          color: Colors.black,
          constraints: BoxConstraints (
              minHeight: 300
          ),
          child: CachedNetworkImage(
            imageUrl: _mediaUrl!,
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.black26),
            fit: BoxFit.fill, //fit: BoxFit.contain,  여기로 바뀜
            cacheKey: _mediaUrl,
          ),
        );

      case MediaType.video :

        if (_mediaInfo.url == null || _mediaInfo.url!.isEmpty) { //주소가 없는건 거르자...
          return _commonError;
        } else if (_mediaInfo.type == MediaPlayType.video_youtube) {
          youTubePlayer = TdiYouTubePlayer(videoId: _mediaInfo.url, mController: Get.find<ListTypeFeedsDetailController>(tag: strControllerTag),);
          return youTubePlayer! ;
        } else if (_mediaInfo.type == MediaPlayType.video_mp4) {
          return TdiVidePlayer(videoUrl: _mediaInfo.url, mController: Get.find<ListTypeFeedsDetailController>(tag: strControllerTag),);
        } else {
          return _commonError;
        }

      default :
        return _commonError;
    }
  }

  double _getContentProp (ListTypeFeedsDetailController controller) {
    double _asp = 0.0;
    if (controller.currentMedia.width == null || controller.currentMedia.width == 0
        || controller.currentMedia.height == null || controller.currentMedia.height == 0) {
      _asp = 300 / Get.width;
    } else {
      _asp = controller.currentMedia.height! / controller.currentMedia.width!;
    }

    customLogger.d("비율 --> $_asp ------> ${controller.currentMedia.height} / ${controller.currentMedia.width}");
    return _asp;
  }

  @override
  Widget build(BuildContext context) {
    mediaContext = context ;
    print('???????${Get.height}??????????구르니??>>>>>>>>>>>>>>>>!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    return GetBuilder<ListTypeFeedsDetailController> (
      tag: strControllerTag,
      init: ListTypeFeedsDetailController (),
      builder:(controller) =>
      (controller.data.article_medias != null && controller.data.article_medias!.length > 1) ?
      Obx (() {
        return Container (
            color: Colors.black,
            child: Stack (
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        aspectRatio: (controller.orientation.value == Orientation.portrait) ? 1 / 1 : Get.width / Get.height,
                        height: check_height(controller.data),
                        // height: controller.orientation.value == Orientation.landscape ? Get.height : Get.width,//여기로 바뀜
                        viewportFraction : 1,
                        onPageChanged: (index, reason) {
                          controller.mediaCarouselCurrent.value = index;
                        }
                    ),
                    carouselController: controller.mediaCarouselController,
                    items: controller.data.article_medias!.map((item) => Container(
                      width: Get.width,
                      height: item.height?.toDouble(),
                      alignment: Alignment.center,
                      child: _getMediaItemView (item, enumFromString(PlatformType.values, controller.data.platform!)),
                    )).toList(),
                  ),

                  Positioned (
                      bottom: getUiSize(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.data.article_medias!.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => controller.mediaCarouselController!.animateToPage(entry.key),
                            child: Container(
                              width: getUiSize(3),
                              height: getUiSize(3),
                              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(controller.mediaCarouselCurrent.value == entry.key ? 1.0 : 0.5)),
                            ),
                          );
                        }).toList(),
                      )
                  )
                ])
        );
      })
          : (controller.data.article_medias == null || controller.data.article_medias!.length == 0) ?
      Container (
        height: controller.orientation.value == Orientation.portrait ? isTabletSize() ? Get.width * 0.6 : Get.width : Get.height,
        width: Get.width,
        color: Colors.black,
        // child: Positioned(
        //     left: getUiSize (0.4),
        //     top: getUiSize (0.1),
        //     child: Expanded(child: Lottie.asset('assets/splash.json'), flex: 9),
        // ),
      )
          :
      Container (
        width: Get.width,
        height: check_height(controller.data),
        // height: controller.orientation.value == Orientation.portrait ? isTabletSize() ? Get.width * 0.6 : Get.width : Get.height,
        color: Colors.black,
        alignment: Alignment.center,
        child:  _getMediaItemView(controller.currentMedia, enumFromString(PlatformType.values,(controller.data.platform!.replaceAll('-','')))),
      )

      ,
    );
  }
  double check_height(FeedsItemDto data){
    print('${getUiSize (69)}shshsh노노노노노높이느는느느느는????>${Get.width}>>>>>>>>${Get.height}>>>>>>>${data.article_medias![0].height}>>>>>>>>>>>>>${data.article_medias![0].height!/Get.width}');
    return  (data.article_medias![0].height!/Get.width >  3) ? (Get.width + getUiSize (69)) : Get.width  ;
  }
}