import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../controller/dashboard_controller.dart';
import '../controller/feed_controller.dart';
import '../utils/utils_sized.dart';
import 'feed/feed_item_view.dart';

class FeedPage extends GetView<FeedController> {
  // final _refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
    return Scaffold(
      body: RefreshIndicator(
          key: controller.refreshKey,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                    height: getUiSize(70),
                    width: double.infinity,
                    color : Colors.red,
                    child : Center(child:Text("앱바"))),
                // child: Image.asset('images/app_bar.png',fit: BoxFit.fill,)),
                //////////////////////////////////////////////
                SizedBox(height: getUiSize(9),),
                //////////////////////////////////////////////
                Expanded(
                    child: SingleChildScrollView (
                      controller: controller.scrollController,
                      physics: AlwaysScrollableScrollPhysics (),
                      child: Container (
                        child: Column (
                          children: [
                            Obx((){
                              return _feedGridView(controller);
                            }),
                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          onRefresh: () => controller.refreshFeeds (true)
      )
      // body : GetBuilder<FeedController> (
      //     init: FeedController (),
      //     builder: (controller) => RefreshIndicator(
      //         key: controller.refreshKey,
      //         child: SafeArea(
      //           child: Column(
      //             children: [
      //               Container(
      //                 height: getUiSize(70),
      //                 width: double.infinity,
      //                 color : Colors.red,
      //                 child : Center(child:Text("앱바"))),
      //                 // child: Image.asset('images/app_bar.png',fit: BoxFit.fill,)),
      //               //////////////////////////////////////////////
      //               SizedBox(height: getUiSize(9),),
      //               //////////////////////////////////////////////
      //               Expanded(
      //                   child: SingleChildScrollView (
      //                     controller: controller.scrollController,
      //                     physics: AlwaysScrollableScrollPhysics (),
      //                     child: Container (
      //                       child: Column (
      //                         children: [
      //                           _feedGridView(controller)
      //                         ],
      //                       ),
      //                     ),
      //                   )
      //               ),
      //             ],
      //           ),
      //         ),
      //         onRefresh: () => controller.refreshFeeds (true)
      //     )
      // ),
      // floatingActionButton: floatingListViewLow(),
    );
  }

  /** 스태거드 그리드 뷰 */
  Widget _feedGridView (FeedController controller) {
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
    //처음 서버타기전
    if (controller.data == null){ // || controller.list.length == 0) {
        return Center(child: Text('로딩중...'),);
      // return SkeletonGridLoader(
      //   builder: Card(
      //     color: Colors.transparent,
      //     child: GridTile(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           ClipRRect(
      //             borderRadius: BorderRadius.circular(10.0),
      //             child: Container(
      //               width: getUiSize(110),
      //               height: getUiSize(100),
      //               color: Colors.white,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   items: 9,
      //   itemsPerRow: 2 ,
      //   period: Duration(seconds: 2),
      //   highlightColor: Color(0xff454f63),
      //   direction: SkeletonDirection.ltr,
      //   childAspectRatio: 1,
      // );
    }
    //정상적으로 서버 탔지만 데이터가 없을떄
    else if(controller.data.value.statusCode == 200 && controller.list.length == 0){
      return Container (
        color: Colors.white,
        // height: double.infinity
        height: 600,
      );
    }else{
      return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        // controller: controller.scrollController,
        physics: NeverScrollableScrollPhysics (),
        primary: false,
        key: PageStorageKey ("fuckedOne${Get.find<DashboardController>(tag:'mainTag').crossCount.value}"),
        padding: EdgeInsets.symmetric(horizontal: getUiSize(5)),
        // padding: EdgeInsets.symmetric(horizontal: Constants.feed_tab_horizontal_padding),
        crossAxisCount: 4, //isTabletSize() ?  6 : 4 ,
        itemCount: controller.list.length,
        itemBuilder: (BuildContext context, int index){
          return FeedItemView (
            dto: controller.list[index], index: index,
            onTap: () {
              controller.detailPageGo(index);
            },
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: getUiSize(5.2),
        crossAxisSpacing: getUiSize(5.2),
      );
    }
  }
}