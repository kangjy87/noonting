import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/login_controller.dart';
import '../utils/utils_sized.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) => Container(
          child: Column(
            children: [
              SizedBox(height: 200,),
              GestureDetector(
                child: Container(
                  // padding: EdgeInsets.all(30),
                  width: getUiSize(250),
                  height: getUiSize(40),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(''),
                        ),
                        // Image.asset(
                        //   'images/google.png',
                        //   height: getUiSize(24),
                        //   width: getUiSize(24),
                        // ),
                        SizedBox(width: 30,),
                        Container(
                          width: getUiSize(120),
                          child: Text('구글로 시작하기',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'NanumRoundB',
                                  fontSize: getUiSize(11),
                                  color: Color(0xff454f63))),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(''),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  controller.googleLogin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}