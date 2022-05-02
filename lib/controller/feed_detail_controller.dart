
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:noonting/controller/tdi_orientation_controller.dart';
import 'package:carousel_slider/carousel_controller.dart';
import '../api/dio_client.dart';
import '../api/feeds_client.dart';
import '../model/feeds/feeds_detail_dto.dart';
import '../model/feeds/feeds_item_dto.dart';
import '../model/feeds/feeds_likes_result_dto.dart';
import '../model/feeds/feeds_list_dto.dart';
import '../routes/app_routes.dart';
import '../ui/feed/media_item_view.dart';
import '../utils/config.dart';
import 'feed_controller.dart';

class ListTypeFeedsDetailController extends TdiOrientationController {
  late MediaItemView mediaItemView ;

  bool reSearch = false ;
  //////피드 리스트
  final List<FeedsItemDto> list = <FeedsItemDto>[].obs;
  int clickPosition = 0;

  RxBool isFavorite = false.obs;
  RxBool isLike = false.obs;
  RxInt likeCount  = 0.obs ;

  final _data = FeedsItemDto ().obs;
  FeedsItemDto get data => _data.value;
  set data (FeedsItemDto t) => _data.value = t;

  ScrollController scrollController = ScrollController();

  var strNaverBlogUrl = "".obs ;
  var webViewHeight = double.infinity.obs ;
  RxBool onBackCheck = false.obs;

  //현재 미디어 반환
  final RxInt mediaCarouselCurrent = 0.obs;
  ArticleMediaItemDto get currentMedia => data.article_medias![mediaCarouselCurrent.value];
  CarouselController? mediaCarouselController;

  bool feedPageCheck = true ; //피드페이지먼 true 마이즐겨찾기페이지면 false

  int page = 0;
  int per_page = 50;
  bool listEnd = false;
  bool isLoading = false;
  FeedsListDto? feedData;

  @override
  void onInit () async {
    super.onInit();
    reSearch = false ;
    print('걸려듬????????????????????????111');
    mediaCarouselController = CarouselController();
    print('걸려듬????????????????????????222222');
    if(Get.parameters['page'] != null && Get.parameters['page'] == 'FeedDetailPage'){
      print('걸려듬????????????????????????');
      FeedsItemDto getData = Get.arguments as FeedsItemDto;
      if(getData.platform == 'naver-blog'){
        strNaverBlogUrl.value = getData.url! ;
      }
      data = await getFeedDetail ('${getData.id}');
      feedPageCheck = true ;
    }
    else if(Get.parameters['page'] != null && Get.parameters['page'] == 'FavoritePage'){
      FeedsItemDto getData = Get.arguments as FeedsItemDto;
      if(getData.platform == 'naver-blog'){
        strNaverBlogUrl.value = getData.url! ;
      }
      data = await getFeedDetail ('${getData.id}');
      feedPageCheck = false;
    }
    else if (Get.arguments.runtimeType == FeedsItemDto) {
      print('걸려듬????????????????????????asdfasdfsadfsadfdddddddddddd');
      FeedsItemDto getData = Get.arguments as FeedsItemDto;
      if(getData.platform == 'naver-blog'){
        strNaverBlogUrl.value = getData.url! ;
      }
      data = await getFeedDetail ('${getData.id}');
    } else if (Get.arguments.runtimeType == String) {
      print('걸려듬????????????????????????asdfasdfsadfsadfddddddddddddvvvvvvvvvvvvvv');
      data = await getFeedDetail (Get.arguments);
    }
    print('ㅇㅇㅇㅇㅇㅇㅇㅇ걸려듬????????????????????????${Get.arguments.runtimeType}');
    feedInit();
  }
  //피드 초기 셋팅
  feedInit(){
    //피드리스트
    list.clear();
    page = 1;
    listEnd = false;
    getFeeds();
    scrollController.addListener(() {
      try {
        double _remainDistance = scrollController.position.maxScrollExtent - scrollController.offset;
        if (_remainDistance <= Get.height * 3 &&

            ///--> 스크린 크기의 몇배의 스크롤 높이가 남으면 로드할거냐????
            !scrollController.position.outOfRange) {
          //다음페이지 로드
          if (!listEnd && !isLoading) {
            page += 1;
            getFeeds();
          }
        }

      } catch (error) {
        //nothing yet;
      }
    });
  }
  //상세 데이터
  Future<FeedsItemDto> getFeedDetail (String articleId) async {
    FeedsItemDto _result = FeedsItemDto();
    // if(EasyLoading != null){
    //   EasyLoading.show();
    // }
    final client = FeedsClient(DioClient.dio);
    await client.getFeedDetail (articleId,TestData.user_id, SharedPrefKey.C9_KEY).then((FeedsDetailDto result) {
      // if(EasyLoading != null){
      //   EasyLoading.dismiss();
      // }
      _result = result.data as FeedsItemDto;
      if(_result.platform == 'naver-blog'){
        strNaverBlogUrl.value = _result.url! ;
      };
      print('?!@#!@#!@#!@#!@#!@#!@#!@#!@#!!!!!!!!!!!!!!!!');
      update();
    }).onError((DioError error, stackTrace) {
      // if(EasyLoading != null){
      //   EasyLoading.dismiss();
      // }
      print('?!@#!@#!@#!@#!@#!@#!@#!@#!@#ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ');
      // EasyLoading.dismiss();
    });

    return _result;
  }
  /**
   * 피드 리스트
   */
  Future<void> getFeeds () async {

    isLoading = true;
    final client = FeedsClient(DioClient.dio);
    await client.getFeeds(
        SharedPrefKey.media_id /** 1 ~ 3 */, page, per_page, SharedPrefKey.C9_KEY,'','',TestData.user_id
    ).then((result) {
      feedData = result;
      //가라 데이타 ---------------------------------------------------------
      // list.add(fakeMe);
      //가라 데이타 ---------------------------------------------------------
      list.addAllIf(feedData!.data!.articles!.length > 0, feedData!.data!.articles!);
      print('>>>>>>>>>>>피피피피드드드드리리리리스스스스트트ㅡ틑ㅌ>>>>>>>${list.length}');
      if (feedData!.data!.articles!.length < per_page) {
        listEnd = true;
      }

      isLoading = false;

      update ();

    }).catchError((Object obj) async {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          update();
          break;
        default:
        //nothing yet;
      }
      isLoading = false;
    });

  }
  //타이틀바 셋팅
  String strAppbarTitle(){
    String strTitle = '소식';
    if(data == null || data.title == null){
      return strTitle ;
    }else if(data.title!.isEmpty){
      return strTitle ;
    }else if(data.title!.length > 20){
      return '${data.title!.substring(0,19)}...' ;
    }else{
      return data.title! ;
    }
  }

  //좋아요
  Future<void> setLikes () async {
    LikesDto likes = LikesDto();
    likes.media_id = 1 ;
    likes.user_id = '${TestData.user_id}' ;
    likes.article_id = data.id ;
    likes.behavior_type = data.is_like == false ? 'like' : 'like' ;
    final client = FeedsClient(DioClient.dio);
    var returnServerData = await client.setLike(
        '${data.id}',
        likes.behavior_type!,
        SharedPrefKey.C9_KEY,
        likes
    ).then((result) {
      data.is_like = !data.is_like! ;
      isLike.value = data.is_like! ;
      LikesResultDto returnData = result ;
      int intlikeCount = returnData.data!.like! ;
      likeCount.value = intlikeCount ;
      if(data.article_detail == null){
        data.article_detail = ArticleDetail();
      }
      data.article_detail!.like =  intlikeCount ;
      update ();
      if(feedPageCheck){
        FeedController listController = Get.find<FeedController>();
        listController.list[listController.clickPosition] = data ;
      }else{
        reSearch = true ;
        // FavoriteController listController = Get.find<FavoriteController>();
        // listController.list[listController.clickPosition].article = data ;
      }
    }).catchError((Object obj) async {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.에러잔슴');
          final res = (obj as DioError).response;
          update();
          break;
        default:
        //nothing yet;
      }
    });
  }

  //피드리스트 클릭시 선택한 값디테일 리스트
  void detailPageGo(int index)async{
    clickPosition = index;
    if(Get.find<FeedController>().youtubePlayerController!= null){
      Get.find<FeedController>().youtubePlayerController!.pause();
    }
    // Get.put(ListTypeFeedsDetailController(),tag:'${list[index].id}');
    Get.toNamed('${AppRoutes.ListTypeFeedDetailPage}/value?page=FeedDetailPage', arguments: list[index],preventDuplicates: false)!.then((value){
    }); /** 상세페이지로!! */
  }

  /** for share */
  // Future<void> shareMe ()async {
  //   Get.find<BaseScaffoldController>().isLoading = true;
  //   print ("미리보기 이미지 : ");
  //   MediaInfo _mediaInfo = ContentsUtil.getFeedsThumbNailInfo(data);
  //   print ("미리보기 이미지 : ${_mediaInfo.url!}");
  //   print ("id : ${data.id}");
  //
  //   Uri url = await createDynamicLink(
  //       true, AppRoutes.ListTypeFeedDetailPage, data.id.toString(),
  //       _mediaInfo.url!,
  //       data.title!,
  //       data.contents!
  //   );
  //   customLogger.d ("미리보기 이미지 : ${_mediaInfo.url!}");
  //   customLogger.d ("dynamic link : ${url.toString()}");
  //   customLogger.d ("id : ${data.id}");
  //   Share.share(url.toString());
  //
  //   Get.find<BaseScaffoldController>().isLoading = false;
  // }

  /** 딥링크 생성 */
  // static Future<Uri> createDynamicLink(bool short, String route, String params, String imageURL, String title, String description) async {
  //
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //       uriPrefix: Constants.deeplink_prefix_domain,
  //       link: Uri.parse('${Constants.deeplink_prefix_domain}$route/$params'),
  //       androidParameters: AndroidParameters(
  //         packageName: Constants.androidApplicationId,
  //         minimumVersion: 1,
  //       ),
  //       dynamicLinkParametersOptions: DynamicLinkParametersOptions(
  //         shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
  //       ),
  //       iosParameters: IosParameters(
  //         bundleId: Constants.appleBundleId,
  //         minimumVersion: '1.0.0',
  //       ),
  //       socialMetaTagParameters: SocialMetaTagParameters (
  //           imageUrl: Uri.parse (imageURL),
  //           title: title,
  //           description: description
  //       )
  //   );
  //
  //   Uri url;
  //   if (short) {
  //     final ShortDynamicLink shortLink = await parameters.buildShortLink();
  //     url = shortLink.shortUrl;
  //   } else {
  //     url = await parameters.buildUrl();
  //   }
  //
  //   return url;
  //
  // }
}
class ListTypeFeedsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTypeFeedsDetailController>(() => ListTypeFeedsDetailController());
  }
}