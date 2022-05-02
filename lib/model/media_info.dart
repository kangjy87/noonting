//이미지 객체

import '../utils/enums.dart';

class MediaInfo {

  String? url;
  double? width;
  double? height;
  MediaPlayType? type;

  MediaInfo ({
    this.url,
    this.width,
    this.height,
    this.type
  });
}