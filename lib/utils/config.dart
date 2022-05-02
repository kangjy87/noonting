import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noonting/utils/utils_sized.dart';



class Font {
  static const TmonMonsori = "TmonMonsori";
  static const NotoSansCJKkrBold = "NotoSansCJKkrBold";
  static const NotoSansCJKkrRegular = "NotoSansCJKkrRegular";
}
class TestData{
  static const user_id = 38 ;
}
class SharedPrefKey{
  static const media_id = 4 ;
  static const C9_KEY = 'tingstar';
  static const CURATOR9_TOKEN = 'eyJpdiI6ImRna2YyMi9jWkx2RmJMcC8zQ1ZqOXc9PSIsInZhbHVlIjoiQitMZUFGWHZ5eXp4cCsyemtsa2l3Zz09IiwibWFjIjoiMGEzMjdjODNiZmI0YzZkOTI3NjhmZmQ4YTkyNTFkMzA5MzYyMzNiYmIxZjA5YzljNWIxMWI0YjQxMjkyNTQ5NyJ9';
}

class AppIcons {
  static const ICON_PATH = "images/";
  static const ic_insta = ICON_PATH + "045-instagram.svg";
  static const ic_music = ICON_PATH + "057-music.svg";
  static const ic_weather = ICON_PATH + "006-weather.svg";
  static const ic_market = ICON_PATH + "023-market.svg";

  static const logo_apple = ICON_PATH + "logo_apple.svg";
  static const logo_google = ICON_PATH + "logo_google.svg";
  static const logo_kakao = ICON_PATH + "logo_kakao.svg";

  static const ic_logo= ICON_PATH + "logo_icon.png";
  static const ic_video_play = ICON_PATH + "play_icon_1.png";
  static const ic_heart = ICON_PATH + "heart_icon_1.png";
  static const ic_heart_on = ICON_PATH + "heart_icon_1_on.png";
  static const ic_heart2 = ICON_PATH + "ic_heart2.png";
  static const book_makr_off = ICON_PATH + "book_makr_off.png";
  static const book_makr_on = ICON_PATH + "book_makr_on.png";
  static const share_icon = ICON_PATH + "share_icon.png";

  /** for tabs **/
  static const ic_tab_home = ICON_PATH + "home_icon.svg";
  static const ic_tab_ticketing = ICON_PATH + "ticketing_icon.svg";
  static const ic_tab_feed = ICON_PATH + "feed_icon.svg";
  static const ic_tab_clip = ICON_PATH + "clip_icon.svg";

  /** for topper icons */
  static const ic_event = ICON_PATH + "event_icon.svg";
  static const ic_event_white = ICON_PATH + "event_icon_white.svg";
  static const ic_mypage = ICON_PATH + "mypage_icon.svg";
  static const ic_mypage_white = ICON_PATH + "mypage_icon_white.svg";
  static const ic_notice = ICON_PATH + "notice_icon.svg";
  static const ic_notice_white = ICON_PATH + "notice_icon_white.svg";

  /** for common things */
  static final IconData icondata_back = Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back;
  static const ic_back = ICON_PATH + "back_btn.svg";
  static const ic_feed_popup_btn = ICON_PATH + "feed_popup_btn.svg";
  static final ic_selected = ICON_PATH + "select_icon.svg";
  static final ic_checked = ICON_PATH + "check_icon.svg";

  static final ic_search = ICON_PATH + "search_icon.svg";
  static final ic_x = ICON_PATH + "x_btn.svg";
}


//이미지 객체
class ImageDto {

  String? url;
  int? width;
  int? height;

  ImageDto ({
    this.url,
    this.width,
    this.height
  });

}

class Images {
  static const IMG_PATH = "images/";
  static const img_placeholder = IMG_PATH + "placeholder.png";
  static const img_ic_band = IMG_PATH + "band.png";
  static const img_ic_fbook = IMG_PATH + "fbook.png";
  static const img_ic_google = IMG_PATH + "google.png";
  static const img_ic_insta = IMG_PATH + "insta.png";
  static const img_ic_kstory = IMG_PATH + "kstory.png";
  static const img_ic_nband = IMG_PATH + "nband.png";
  static const img_ic_nblog = IMG_PATH + "nblog.png";
  static const img_ic_tstory = IMG_PATH + "tstory.png";
  static const img_ic_tweeter = IMG_PATH + "tweeter.png";
  static const img_ic_youtube = IMG_PATH + "youtube.png";
  static const img_no_profile = IMG_PATH + "no_profile.png";
  static const img_no_thumbnail = IMG_PATH + "no_thumbnail.png";

  /** 아래는 깨진 이미지들 때문에 사용한 임시 이미지들... 삭제예정 */
  static List<ImageDto> SampleImages = [

    ImageDto(
        url: "https://images-na.ssl-images-amazon.com/images/S/pv-target-images/c24f81b95634562bfa6380091887e738f7bdb211af8761e73afaf463a0015d15._RI_V_TTW_.jpg",
        width: 1200,
        height: 1600
    ),
    ImageDto(
        url: "https://fever.imgix.net/plan/photo/7bba64dc-5552-11e9-b555-064931504376.jpg?w=550&h=550&auto=format&fm=jpg",
        width: 550,
        height: 550
    ),
    ImageDto(
        url: "http://tkfile.yes24.com/upload2/PerfBlog/202104/20210401/20210401-38766.jpg",
        width: 430,
        height: 602
    ),
    ImageDto(
        url: "https://cdnticket.melon.co.kr/resource/image/upload/marketing/2021/07/202107050922497f93ecca-30dd-44f3-a207-31f95f830958.jpg",
        width: 420,
        height: 594
    ),
    ImageDto(
        url: "https://d28erbnojfkip4.cloudfront.net/content/uploads/2021/05/TLK-TWIO-3000x1418-NoButton-scaled.jpg",
        width: 2560,
        height: 1263
    ),
    ImageDto(
        url: "https://theprommusical.com/wp-content/uploads/2020/12/PROM-mobile-website-image-Coming-Soon.jpg",
        width: 640,
        height: 1045
    ),
    ImageDto(
        url: "https://file.themusical.co.kr/fileStorage/ThemusicalAdmin/Play/Image/201702011101001N8L2KP311I07112.jpg",
        width: 419,
        height: 600
    )

  ];


  static int rotateNum = 0;
  static ImageDto getSampleImagesForFeed () {
    rotateNum = (rotateNum < SampleImages.length - 1) ? rotateNum + 1 : 0;
    return SampleImages[rotateNum];
  }
}

class Constants {
  /** 실서비스용 */
  static const String server_mode_name = "라이브 서버";
  static const String Q_API_BASE_URL = "https://dev.api.curator9.com";  //테스트 (베포시 필수 변경)
  // static const String Q_API_BASE_URL = "https://api.curator9.com"; //라이브
  static const String API_BASE_URL = 'https://dev.tt.tdi9.com';
  static const String CDN_URL = "https://chuncheon.blob.core.windows.net/chuncheon/"; // 테스트 (베포시 필수 변경)
  // static const String CDN_URL = "https://c9bloodpressure.azureedge.net/"; //라이브
  static const int feed_media_ID = 4;


  static final general_horizontal_padding = getUiSize(15);
  static final narrow_horizontal_padding = getUiSize(20);

  static final feed_tab_horizontal_padding = getUiSize(10.0);

  /** 이용약관 및 개인정보 처리 방침 URL */
  static const terms_of_use_url = "https://blog.evnet.kr/755";
  static const privacy_policy_url = "https://blog.evnet.kr/739";


}