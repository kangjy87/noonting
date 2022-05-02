import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    googleLoad();
  }
  /**
   * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   *
   * 구글로그
   */
  void googleLoad() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void googleLogin() async {
    User? user = await currentUser();
    print('!!!!!!!!!!!!!!!!!${user!.displayName}>>>>>>>>>>>>>>>${user.email}');

    userGubun(user.uid, user.email! ,'google');
  }

  Future<User?> currentUser() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if(account == null){
      // EasyLoading.dismiss();
    }
    final GoogleSignInAuthentication authentication =
    await account!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);

    final UserCredential authResult =
    await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;
    return user;
  }

  void userGubun(String? uuid, String email, String provider) async{
    print('>구구구국글로그인 >>>>>>>>>>>>>>>>>${uuid}');
    // GetClientCredentialsGrantDto gcDto = await getClientCredentiaksGrant();
    // String appKey = "Bearer ${gcDto.access_token}" ;
    // print('서버키 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${appKey}');
    // await FirebaseMessaging.instance.getToken().then((token){
    //   setUserInfo(uuid, email, provider, (){
    //     TdiServers(bloodPressureServer: (BloodPressureServer bps) async {
    //       UsersDto task = UsersDto();
    //       task.uuid = uuid ;
    //       task.email = email ;
    //       task.provider = provider ;
    //       task.fcm_token = token ;
    //       final resp = await bps.UsersInfo(appKey, task);
    //       print('저장된값?????????>>>>>>>>>>>${resp.data!.id}>>>>>>>>>>>>>>${resp.data!.access_token}');
    //       EasyLoading.dismiss();
    //       if(resp.data != null && resp.data!.nickname != null && resp.data!.nickname != ""){
    //         setUserAccessToken(resp.data!.access_token);
    //         setUserAddInfo(resp.data!.nickname, resp.data!.gender, resp.data!.age,resp.data!.id!, (){
    //           // Get.offAll(DashboardPage(),transition: Transition.rightToLeft);
    //           Get.offAllNamed(AppRoutes.DASHBOARD);
    //         });
    //       }else{
    //         Get.offAllNamed(AppRoutes.JoinAddInfo);
    //       }
    //     });
    //   });
    // });
  }
}