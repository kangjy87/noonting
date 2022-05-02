
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/dashboard_controller.dart';
import '../utils/utils_sized.dart';
import 'feed_page.dart';

class DashboardPage extends StatelessWidget with WidgetsBindingObserver{
  List _list=[
    // SampleImgPage(),
    FeedPage(),
    FeedPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: GetBuilder<DashboardController>(
      tag: 'mainTag',
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          body: this._list[controller.tabIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.tabIndex,
            onDestinationSelected: (int newIndex) {
              print('<><><>>>>>>>>>>>>>>>>>>>>${newIndex}');
              controller.changeTabIndex(newIndex);
            },
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.eco),
                icon: Icon(Icons.eco_outlined),
                label: 'Feed',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Feed2',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outlined),
                label: 'Feed3',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.video_camera_back),
                icon: Icon(Icons.video_camera_back_outlined),
                label: 'Feed4',
              ),
            ],
          ),

          //margin: EdgeInsets.only(left: 6.0, right: 6.0),
              // child: Stack(
              //   children: [
              //     Image.asset('images/menu_bar.png',fit: BoxFit.fitWidth,),
              //   Positioned(
              //     child: GestureDetector(
              //       onTap: () {
              //         Get.find<DashboardController>(tag:'mainTag').changeImgIndex();
              //         controller.changeTabIndex(0);
              //         },
              //       child: Container(
              //           color: Colors.transparent,
              //           height: getUiSize (50), width: getUiSize (50)),
              //     ), left: 1,bottom: 1,),
              //     Positioned(
              //       child: GestureDetector(
              //         onTap: () {
              //           controller.menuCheck = !controller.menuCheck ;
              //           controller.changeTabIndex(controller.menuCheck ? 1 : 2);
              //         },
              //         child: Container(
              //             color: Colors.transparent,
              //             height: getUiSize (60), width: getUiSize (50)),
              //       ), right: 1,bottom: 1,),
              //   ],
              // ),
              // child: Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Expanded(
              //       flex: 1,
              //       child: Text(''),
              //     ),
              //     GestureDetector(
              //       //update the bottom app bar view each time an item is clicked
              //       onTap: () {
              //         controller.changeTabIndex(0);
              //       },
              //       child: Container(child: Icon(Icons.eleven_mp_sharp,color: controller.tabIndex == 0 ? Colors.pink : null,),
              //           height: getUiSize (40), width: getUiSize (80)),
              //       // child: controller.tabIndex == 0
              //       //     ? Image.asset('images/menu_on_2.png',
              //       //     height: getUiSize (40), width: getUiSize (80))
              //       //     : Image.asset('images/menu_off_2.png',
              //       //     height: getUiSize (40), width: getUiSize (80)),
              //     ),
              //     Expanded(
              //       flex: 1,
              //       child: Text(''),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         controller.changeTabIndex(1);
              //       },
              //       child: Container(child: Icon(Icons.twelve_mp,color: controller.tabIndex == 1 ? Colors.pink : null,),
              //           height: getUiSize (40), width: getUiSize (80)),
              //       // child: controller.tabIndex == 1
              //       //     ? Image.asset('images/menu_on_1.png',
              //       //     height: getUiSize (40), width: getUiSize (80))
              //       //     : Image.asset('images/menu_off_1.png',
              //       //     height: getUiSize (40), width: getUiSize (80)),
              //     ),
              //     Expanded(
              //       flex: 1,
              //       child: Text(''),
              //     ),
              //   ],
              // ),
          //   ),
          // )
        );
      },
    ),
        onWillPop: () async {
          // twoButtonAlert(
          //     context,
          //     '종료',
          //     '앱을 종료 하시겠습니까?',
          //     '아니요', () {
          //   Get.back();
          // },
          //     '예', () {
          //   SystemNavigator.pop();
          //   // exit(0);
          // });
          return false;
        }
    );
  }
}