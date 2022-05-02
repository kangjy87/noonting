import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../api/dio_client.dart';
import '../api/feeds_client.dart';
import '../model/feeds/feeds_item_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../model/feeds/feeds_list_dto.dart';
import '../routes/app_routes.dart';
import '../utils/config.dart';

class FeedController extends GetxController {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  // FeedsListDto? data;
  var data = FeedsListDto().obs;
  final List<FeedsItemDto> list = <FeedsItemDto>[].obs;

  int clickPosition = 0;

  int page = 0;
  int per_page = 50;
  bool listEnd = false;
  bool isLoading = false;

  /** 검색어 및 플랫폼 선택을 위해 */
  final FocusNode searchFocusNode = FocusNode ();
  final TextEditingController searchController = TextEditingController();
  String? platform;
  String? keyword;

  //스크롤 컨트롤러
  ScrollController scrollController = ScrollController();

  YoutubePlayerController? youtubePlayerController ;

  @override
  void onInit () {
    super.onInit();
    list.clear();
    page = 1;
    listEnd = false;
    scrollController.addListener(() {
      try {
        double _remainDistance = scrollController.position.maxScrollExtent - scrollController.offset;
        if (_remainDistance <= Get.height * 2 &&

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
    getFeeds ();
  }
  void detailPageGo(int index)async{
    //즐겨찾기에서 바로 데이터 바꿔주기 위
    clickPosition = index;
    /** 상세페이지로!! */
    // Get.put(ListTypeFeedsDetailController(),tag:'${list[index].id}');
    Get.toNamed('${AppRoutes.ListTypeFeedDetailPage}/value?page=FeedPage', arguments: list[index],preventDuplicates : false)!.then((value){
    });
  }

  Future<void> getFeeds () async {
    isLoading = true;
    final client = FeedsClient(DioClient.dio);
    await client.getFeeds(
      // 1 /** 1 ~ 3 */, page, per_page, SharedPrefKey.C9_KEY,('#google-news'),keyword,usersInfo.id
        SharedPrefKey.media_id /** 1 ~ 3 */, page, per_page, SharedPrefKey.C9_KEY,(platform),keyword,TestData.user_id
    ).then((result) {
      data.value = result;
      print('먹겅>>>>>>>>>>>>${data.value.data!.articles!.length}>>>>>>>>>>>>>>>>>>>>${data.value.data!.articles!.length > 0}');
      list.addAllIf(data.value.data!.articles!.length > 0, data.value.data!.articles!);
      // if(data!.data!.articles!.length > (per_page-(per_page/2))){
      //   keywordList();
      // }
      if (data.value.data!.articles!.length < per_page) {
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

  //새로 고침
  Future<void> refreshFeeds (bool withIndicator) async {
    if (withIndicator) refreshKey.currentState!.show (atTop: true);
    list.clear();
    page = 1;
    listEnd = false;
    await getFeeds ();
  }

  /** 검색 */
  void searchFeeds (String? keyword) {
    this.keyword = keyword != null ? "#$keyword" : null;
    searchController.text = keyword ?? "";
    refreshFeeds(false);
  }

  /** 맨위로 올라가세요!! */
  void scrollToTop () {
    scrollController.animateTo(0, duration: Duration (milliseconds: 500), curve: Curves.easeOut);
  }
}