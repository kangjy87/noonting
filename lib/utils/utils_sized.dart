/**
 * 아래 주석 없으면 null-safety 지원 안되는 위 플러그인에서 에러남
 * flutter run --no-sound-null-safety 을통해 작성해야함
 * */

import 'package:get/get.dart';

/** 나 약간 태블릿 사이즈 임?? */
bool isTabletSize () {
  double _screenRatio = Get.width / Get.height;
  double _turningPoint = 0.7;
  return  _screenRatio > _turningPoint ? true : false;
}

bool isSmallSize(){
  double _screenRatio = Get.width / Get.height;
  double _turningPoint = 0.42;
  return _screenRatio < _turningPoint ? true : false;
}
/** prop for object height */
// final double W_PROP = Get.width / 281.3;
// double getUiSize (double size) {
//   return size * W_PROP;
// }
/** prop for object height */
// final double W_PROP = Get.width / 281.3;
double getUiSize (double size) {
  return size ;
  // print('다시계산?????????');
  // return isTabletSize()
  //     ? size * W_PROP / 2
  //     : size * W_PROP;
}