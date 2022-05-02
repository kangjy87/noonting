/** SNS type -- platform */
enum PlatformType {
  youtube,
  instagram,
  googlenews
}

/** Feed media type */
enum MediaType {
  video,
  image,
}

/** Feed media play type */
enum MediaPlayType {
  image_show,
  video_youtube,
  video_mp4
}

enum AccountProviderType {
  kakao,
  google,
  apple,
  naver,
  facebook
}

/** access token type */
enum TokenType {
  Bearer
}


/** topper icon menu selected */
enum TopperIconMenu {
  event,
  notice,
  mypage,
  none
}

enum TopperIconBacgroundMode {
  bright,
  dark
}

/** 웹뷰 종류 */
enum WebViewType {
  url_link,
  ticketing_page,
}


/** 게시판 타입 */
enum NoticeType {
  faq,
  notice
}

/** 약관타입 */
enum PolicyType {
  privacy,
  terms
}

/** Y / N 값 */
enum IsYN {
  Y,
  N
}

/** AppMeterialButton icon alignment */
enum BtnIconAlignment {
  start,
  center,
  end
}


/** event list 타입 */
enum EventListType {
  all,
  my
}

/** event type */
enum EventType {
  A, //--> 일반
  P, //--> 응모
  R, //--> 공연얘배.
  C, //--> 포토카드
}



/** 피드 게시중단 신고하기 종류 */
enum ReportType {
  NONE,
  COPYRIGHT,
  SEXUAL,
  ETC
}


/** 피드 데이타 이벤트 */
enum FeedEvent {
  click,
  like
}


/** String to enum */
T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value);
}