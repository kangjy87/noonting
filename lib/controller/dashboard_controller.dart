import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../utils/utils_sized.dart';

class DashboardController extends GetxController with WidgetsBindingObserver{
  var tabIndex = 0;
  RxInt crossCount = (isTabletSize() ? 6 : 4).obs;
  RxBool tabletCheck = isTabletSize().obs ;
  bool menuCheck = false ;
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
  var imgCount = 4.obs ;
  void changeImgIndex(){
    if(!Get.isRegistered<DashboardController>(tag:'mainTag')){
      Get.put(DashboardController(),tag:'mainTag');
    }
    if(imgCount.value == 0){
      imgCount.value = 4 ;
    }
    imgCount.value --;
    print('>>>>>>>>>>>>>${imgCount.value}');
  }
  @override
  void onInit() {
    // FirebaseUtil.initDynamicLinks(); //--> 파이어 베이스
    // WidgetsBinding.instance!.addObserver(this);
    super.onInit();
  }
  @override
  void onClose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.onClose();
  }
  @override
  void didChangeMetrics() {
    crossCount.value = isTabletSize() ? 6 : 4 ;
    tabletCheck.value = isTabletSize();
  }
}