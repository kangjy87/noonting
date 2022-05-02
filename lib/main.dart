import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:noonting/routes/app_pages.dart';
import 'package:noonting/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(Noonting());
}

class Noonting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360,690), //제플린에 적용되니 해성도를 입력
      builder: (BuildContext context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.Splash,
          getPages: AppPages.list,
        );
      },
    );
  }
}

