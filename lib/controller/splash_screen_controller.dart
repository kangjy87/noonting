import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../routes/app_routes.dart';


class SplashScreenController extends GetxController  with WidgetsBindingObserver{
  final String title = '스플';
  RxBool visible = true.obs;
  @override
  void onInit() {
    super.onInit();
    // clinetCredentialsGrant();
    // feedAuthToken (); /// -- KEVIN 추가
  }

  /**
   * countTimer 시간동안 화면을 기둘해준다.
   */
  startSplash(BuildContext context)async{
    int countTimer = 2;
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) async{
      print('작동됨????????????????${countTimer}');
      if (countTimer != 0) {
        countTimer--;
      } else {
        timer.cancel();
        visible.value = false ;
        // Get.toNamed(AppRoutes.DASHBOARD);
        Get.offAllNamed(AppRoutes.DASHBOARD);
        // Get.offAllNamed(AppRoutes.Login);
      }
    });
  }
  @override
  void didChangeMetrics() {
    // crossCount.value = isTabletSize() ? 6 : 4 ;
    // tabletCheck.value = isTabletSize();
  }
}
