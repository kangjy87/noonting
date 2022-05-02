import 'package:intl/intl.dart';

class FormatUtil {
  static String numberWithComma(int param){
    return new NumberFormat('###,###,###,###').format(param).replaceAll(' ', '');
  }
  // DateTime ---> String
  static String printDateTime(DateTime date, {String? format}) {
    if (date == null) return "";
    return DateFormat(format).format(date);
  }

  static String enumToString (t) {
    return t.toString().split(".")[1];
  }
}