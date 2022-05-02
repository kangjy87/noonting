import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_screen_controller.dart';

class SplashScreenPage extends StatelessWidget{
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    bool _visible = true;
    return GetBuilder<SplashScreenController>(builder: (controller) {
      controller.startSplash(context);
      return Scaffold(
        body: SafeArea(
          child: Obx((){
            return AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: controller.visible.value ? 1.0 : 0.0,
              child: Container(
                color: Color(0xffF4F7FC),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Column(
                    children: [
                      Text('누누누누우웅운팅')
                      // Image.asset('images/splash1.png',fit: BoxFit.fill)
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}