
import 'package:dio/dio.dart';
import 'package:noonting/utils/shared_pref_util.dart';
import '../api/dio_client.dart';
import '../api/feeds_client.dart';
import '../model/feeds/feed_request_body.dart';
import 'db_utils.dart';
import 'enums.dart';

class GuestLogin{
  /**
   * sharedpreferences에 저장된 id값이 없을 경우 guestLogin api 로직을 태워서 게스트 id 값을 받아온다.
   * 저장된값은 sharedpreferences에 저장시켜준다.
   * ----Main에서 호출해서 매번 앱을 킬때마다 체크해주자
   */
  static setGuestLogin()async{
    String? userId = await SharedPrefUtil.getString(SharedPrefKey.USER_ID);
    if(userId == null || userId.isEmpty){
      //로그인 서버 api가 나오게 되면 붙여준다.
      //임의로 넣어주고  완료되면 로그인 데이터를 넣어준다.
      // final client = FeedsClient(DioClient.dio);
      // await client.getFeeds().then((result) {
      //   SharedPrefUtil.setString (SharedPrefKey.USER_ID, result.data!.uuid!); //게스트 로그인으로 받아온 uuid를 넣어주
      // }).catchError((Object obj) async {
      //   // non-200 error goes here.
      //   switch (obj.runtimeType) {
      //     case DioError:
      //       break;
      //     default:
      //     //nothing yet;
      //   }
      // });
    }
  }

  /**
   * sharedpreferences에서 AuthToken값이 없을경우(게스트로그인이라는 소리)
   * 선택한 피드 데이터의 businessTag값이 빈값이 아닌 경우를 체크하여 GuestFeed로컬디비에 현 정보를 저장시켜준다.
   * ----FeedsDetailController에서  들어왔을때 init에서 처리해주자
   */
  static setGuestFeedDataSave(String? business_tag)async{
    //피드 확인 정보 체크
    String? token = await SharedPrefUtil.getString(SharedPrefKey.AUTH_TOKEN);
    if ((token == null || token.isEmpty) && business_tag != null) {
      DBUtils().saveFeedHistory (FeedEvent.click, business_tag!);
    }
  }

  /**
   * 회원가입/로그인을 성공적으로 한경우 GuestFeed로컬디비에 데이터가 있는지 없는지 체크하여 데이터가 있을 경우
   * Api로 데이터를 보낸지 api통신이 완료되면 GuestFeed로컬디비에 데이터를 날려버린다.
   */
  static getGuestFeedDataSendAndClean(String userId)async{
    FeedScoringDto scoringData = FeedScoringDto (
        data: await DBUtils().getFeedHistoryInfo(userId)
    );

    //--> 데이타가 없는데 보낼필요 없다.
    if (scoringData.data == null || scoringData.data!.length == 0){
      return;
    }
    await FeedsClient (DioClient.dio).postFeedScoring(scoringData).then((value) async {
      await DBUtils().deleteFeedHistoryInfo();
    });

    // await Future.delayed(Duration (seconds: 3)); //화면 전환처리떄문에 넣어준듯
  }
}