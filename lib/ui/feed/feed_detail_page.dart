import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/feed_controller.dart';
import '../../controller/feed_detail_controller.dart';
import '../../model/feeds/feeds_item_dto.dart';
import '../../utils/common_ui.dart';
import '../../utils/config.dart';
import '../../utils/format_util.dart';
import '../../utils/utils_sized.dart';
import 'feed_item_view.dart';
import 'media_item_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListTypeFeedsDetail extends StatelessWidget {

  final Completer<WebViewController> _WebveiwControllerComplete = Completer<WebViewController>();
  late WebViewController webveiwcontroller ;
  String _strFirstUrl = "";

  @override
  Widget build(BuildContext context) {
    bool _top = false;
    bool _left = Get.mediaQuery.orientation == Orientation.landscape;
    bool _right = Get.mediaQuery.orientation == Orientation.landscape;
    bool _bottom = Get.mediaQuery.orientation != Orientation.landscape;
    //컨트롤러 테그를 걸어주기 위한 해당 컨텐츠 아이디값
    String strTagId = '${(Get.arguments as FeedsItemDto).id}';
    //피드 컨트롤러가 없을 경우 넣어주기
    if(!Get.isRegistered<FeedController>()){
      Get.put(FeedController());
    }
    //해당 컨텐츠 디테일컨트롤러가 없을 경우 넣어주기
    if(!Get.isRegistered<ListTypeFeedsDetailController>(tag: strTagId)){
      Get.put(ListTypeFeedsDetailController(),tag: strTagId);
    }
    return WillPopScope (
      onWillPop:() {
        Get.back(result: Get.find<ListTypeFeedsDetailController>(tag:strTagId).reSearch);
        return Future(() => false);
      },
      child: Scaffold(
        appBar: _appBarView(context,strTagId),
        backgroundColor: Colors.white,
        body: OrientationBuilder(
          builder: (context, orientation) {
            Get.find<ListTypeFeedsDetailController>(tag:strTagId).orientation.value = orientation;
            return SafeArea (
              top: _top,
              left: _left,
              right: _right,
              bottom: _bottom,
              child: _detailContentView (strTagId,context),
            );
          },
        ),
        // bottomNavigationBar : _bottomNavigationView(context,strTagId),
      ),
    );
  }

  //맵바 설정
  AppBar? _appBarView (BuildContext context,String strTagId) {
    AppBar? _appBar;
    if (Get.mediaQuery.orientation == Orientation.portrait) {
      _appBar = AppBar (
        leading: IconButton(
          onPressed: () {
            Get.back(result: Get.find<ListTypeFeedsDetailController>(tag:strTagId).reSearch);
          },
          icon: Image.asset(
            'images/appbar_back.png',
            height: getUiSize (20),
            width: getUiSize (20),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx((){
                    return Text(Get.find<ListTypeFeedsDetailController>(tag:strTagId).strAppbarTitle(),
                      overflow: TextOverflow.ellipsis,
                      textAlign : TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'NanumRoundB',
                          fontSize: getUiSize(12),
                          color: Color(0xff454f63)),);
                  }),
                ],
              ),
            ),
            SizedBox(width: getUiSize (42)),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
    }
    return _appBar;
  }

  //메인 컨텐츠
  Widget _detailContentView (strTagId,BuildContext context) {
    if(!Get.isRegistered<ListTypeFeedsDetailController>(tag: strTagId)){
      Get.put(ListTypeFeedsDetailController(),tag: strTagId);
    }
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
    return SingleChildScrollView(
      controller: Get.find<ListTypeFeedsDetailController>(tag:strTagId).scrollController,
      physics: AlwaysScrollableScrollPhysics (),
      child: Column (
        children: [
          _selectContent(context, strTagId),
          _feedGridView(strTagId)
        ],
      )
    );
  }

  //선택한 컨텐츠데이터
  Widget _selectContent(BuildContext context, String strTagId){
    return Obx((){
      //네이버 블로그가 아닌 경우
      if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).strNaverBlogUrl.value == ''){
        return _etcContent(context, strTagId);
      }else{
        return _naverBlogUrl(strTagId);
      }
    });
  }

  //일반 컨텐츠(네이버 블로그를 제외한)
  Widget _etcContent(BuildContext context, String strTagId){
    return Column(
      children: [
        Stack (
          children: [
            Column(
              children: [
                Get.find<ListTypeFeedsDetailController>(tag:strTagId).mediaItemView =  MediaItemView(strControllerTag: strTagId,),
                Container (height: getUiSize(32),)
              ],
            ),
            // if (orientation == Orientation.portrait)
            Positioned(
                left: getUiSize(6),
                bottom: 0,
                child: _userThumbnailView (context,strTagId)
            )
          ],
        ),

        // if (orientation == Orientation.portrait)
        Container(
            padding: EdgeInsets.fromLTRB(getUiSize(21.8), getUiSize(5), getUiSize(21.8), getUiSize(21.8)),
            child: Column (
              children: [
                /** 별점 */
                Row (
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child : Container (
                        padding: EdgeInsets.all(getUiSize(3)),
                        width: getUiSize(16.5),
                        height: getUiSize(26),
                        child: Obx((){
                          return Image.asset(Get.find<ListTypeFeedsDetailController>(tag:strTagId).isLike == false ? AppIcons.ic_heart2 : AppIcons.ic_heart_on, height: getUiSize(10),);
                        }),
                      ),
                      onTap: () {
                        // Get.find<ListTypeFeedsDetailController>(tag:strTagId).setLikes();
                      },
                    ),
                    SizedBox (width: getUiSize(3.5),),
                    Obx((){
                      return Text (
                          FormatUtil.numberWithComma(Get.find<ListTypeFeedsDetailController>(tag:strTagId).likeCount.value),
                          style: TextStyle (
                              color: Color (0xff2a2a2a),
                              //fontFamily: Font.NotoSansCJKkrRegular,
                              fontSize: getUiSize(9)
                          )
                      );
                    }),
                  ],
                ),
                SizedBox (height: getUiSize(1),),
                Obx((){
                  if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title != null && Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!.length > 0){
                    return Text (
                      Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!,
                      style: TextStyle (
                          color: Color (0xff2a2a2a),
                          fontFamily: 'NanumRoundB',
                          fontSize: getUiSize(12)
                      ),
                    );
                  }else{
                    return Text('');
                  }
                }),
                Obx((){
                  return SizedBox (height: getUiSize(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title != null && Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.title!.length > 0 ?15 : 0),);
                }),
                // if(controller.data.title != null && controller.data.title!.length > 0)
                Obx((){
                  return Text (
                      (Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.contents != null) ? Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.contents! : "",
                      style: TextStyle (
                          color: Color (0xff2a2a2a),
                          fontFamily: Font.NotoSansCJKkrRegular,
                          fontSize: getUiSize(9)
                      ),
                      textAlign : TextAlign.left
                  );
                }),

                SizedBox (height: getUiSize(20),),
                // 방문하가 버튼
                AppMaterialButton(
                  label: Text (
                    '구매하기',
                    style: TextStyle (fontFamily: Font.NotoSansCJKkrBold, color: Color (0xffeeeeee), fontSize: getUiSize(12)),
                  ),
                  color: Color (0xff0057fb),
                  height: getUiSize(40.5),
                  elevation: 0.0,
                  onPressed: () async {
                    canLaunch (Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.url!).then((value) {
                      launch(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.url!);
                      // Get.toNamed(RouteNames.WEBVIEW, arguments: controller.data!.url!);
                    });
                  },
                ),
              ],
            )
        ),
      ],
    );
  }
  //네이버 블로그 컨텐츠(웹뷰)
  Widget _naverBlogUrl(String strTagId){
    return Column(
      children: [
        Obx((){
          return Container(
            width: double.infinity,
            height: Get.find<ListTypeFeedsDetailController>(tag:strTagId).webViewHeight.value+100,
            child: Stack(
              children: [
                WebView(
                  onWebViewCreated: (WebViewController webViewController) {
                    _WebveiwControllerComplete.complete(webViewController);
                    _WebveiwControllerComplete.future.then((value) => webveiwcontroller = value);
                  },
                  // gestureRecognizers: Set()
                  //   ..add(Factory<VerticalDragGestureRecognizer>(
                  //           () => VerticalDragGestureRecognizer())),
                  initialUrl: Get.find<ListTypeFeedsDetailController>(tag:strTagId).strNaverBlogUrl.value,
                  // initialUrl: Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  gestureNavigationEnabled: true,
                  onPageStarted: (String url) async {
                    if(url.contains('https://m.')){
                      if(_strFirstUrl == ""){
                        _strFirstUrl = url ;
                        Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value = false ;
                      }else if(_strFirstUrl == url){
                        Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value = false ;
                      }else{
                        Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value = true ;
                      }
                    }
                    print('111111111111111111111111111111111111111111$url');
                  },
                  onPageFinished: (String url) async {
                    print('222222222222222222222222222222222222$url');
                    Get.find<ListTypeFeedsDetailController>(tag:strTagId).webViewHeight.value = double.tryParse( await webveiwcontroller.evaluateJavascript("document.documentElement.scrollHeight;"))!;
                    print('>>>>>>>>>>>>>>>${Get.find<ListTypeFeedsDetailController>(tag:strTagId).webViewHeight.value}');
                  },
                  navigationDelegate: (NavigationRequest request) {
                    print('333333333333333333333333333${request.url}');
                    return NavigationDecision.navigate;
                  },
                ),
                _webViewBack(strTagId)
              ],
            ),
            // Stack
          );
        }),
        Container(
          width: getUiSize(35),
          height: getUiSize (3),
          margin: EdgeInsets.only(top: getUiSize(9)),
          decoration: BoxDecoration (
              color: Color (0xffdbdbdb),
              borderRadius: BorderRadius.all(Radius.circular (100))
          ),
        ),
        SizedBox (height: getUiSize(10.5)),
      ],
    );
  }
  //피드 리스트
  Widget _feedGridView(String strTagId){
    return Obx((){
      return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        // controller: controller.scrollController,
        physics: NeverScrollableScrollPhysics (),
        primary: false,
        key: PageStorageKey ("fuckedOne${Get.find<DashboardController>(tag:'mainTag').crossCount.value}"),
        padding: EdgeInsets.symmetric(horizontal: getUiSize(5)),
        crossAxisCount: Get.find<DashboardController>(tag:'mainTag').crossCount.value, //isTabletSize() ?  6 : 4 ,
        itemCount: Get.find<ListTypeFeedsDetailController>(tag:strTagId).list.length,
        itemBuilder: (BuildContext context, int index) => FeedItemView (
          dto: Get.find<ListTypeFeedsDetailController>(tag:strTagId).list[index], index: index,
          onTap: () async {
            Get.find<ListTypeFeedsDetailController>(tag:strTagId).detailPageGo(index);
          },
        ),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: getUiSize(4.2),
        crossAxisSpacing: getUiSize(4.2),
      );
    });
  }

  //바텀 네비게이션바
  Widget _bottomNavigationView(BuildContext context,String strTagId) {
    return Center();
  }

  //웹뷰에서 싸이트 이동시 백버튼
  Widget _webViewBack(String strTagId){
    return Obx((){
      return Visibility(
        visible: Get.find<ListTypeFeedsDetailController>(tag:strTagId).onBackCheck.value,
        child: Align(
          alignment: Alignment(-0.85, 0.95),
          child: FloatingActionButton(
            backgroundColor: Colors.black87,
            child: Icon(Icons.navigate_before),
            onPressed: (){
              webveiwcontroller.goBack();
            },
          ),
        ),
      );
    });
  }

  /** 유저 프로필 이미지 */
  Widget _userThumbnailView (BuildContext context,String strTagId,) {
    String? userThumbnailURL ;
    if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data != null && Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner != null){
      userThumbnailURL = Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner!.thumbnail_url;
    }
    if (userThumbnailURL == null || userThumbnailURL.isEmpty) userThumbnailURL = "";


    return Obx((){
      return Container (
        width: Get.width - getUiSize (2.2),
        child: Row (
          children: [
            Stack (
              alignment: Alignment.center,
              children: [
                Container (
                  width: getUiSize(37),
                  height: getUiSize(37),
                  decoration: BoxDecoration (
                      shape: BoxShape.circle,
                      color: Colors.white
                  ),

                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage (
                    width: getUiSize(32.5),
                    height: getUiSize(32.5),
                    imageUrl: userThumbnailURL!,
                    placeholder: (context, url) => Container(
                      width: 20,
                      height: 20,
                      color: Colors.transparent,
                      child: Image.asset(Images.img_no_profile),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 20,
                      height: 20,
                      color: Colors.transparent,
                      child: Image.asset(Images.img_no_profile),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox (width: 11,),
            Container (
              width: Get.width / 3,
              padding: EdgeInsets.only(top:getUiSize(7)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner != null)
                        Text (
                          Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner!.name!.length > 10 ?
                          '${Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner!.name!.substring(0,7)}...'
                              :Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.article_owner!.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle (
                            color: Color (0xFF2a2a2a),
                            fontFamily: Font.NotoSansCJKkrRegular,
                            fontSize: getUiSize(11),
                          ),
                        ),
                      if(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.date != null)
                        Text (
                          FormatUtil.printDateTime(Get.find<ListTypeFeedsDetailController>(tag:strTagId).data.date!, format: "yyyy.MM.dd"),
                          style: TextStyle (
                              color: Color (0xFF2a2a2a),
                              fontFamily: Font.NotoSansCJKkrRegular,
                              fontSize: getUiSize(7.5)
                          ),
                        )

                    ],
                  ),
                ],
              ),
            ),
            Spacer (flex: 7,),
            //공유하기
            // InkWell(
            //   child: Container (
            //       padding: EdgeInsets.all(getUiSize(3)),
            //       width: getUiSize(16.5),
            //       height: getUiSize(26),
            //       child: Image.asset(AppIcons.share_icon, width: getUiSize(10),)
            //
            //   ),
            //   onTap: () {
            //     Get.find<ListTypeFeedsDetailController>(tag:strTagId).shareMe();
            //   },
            // ),
            Spacer (flex: 1,),

            SizedBox(width: getUiSize(18),)

          ],
        ),
      );
    });

  }
}