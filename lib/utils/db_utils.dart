import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/feeds/feed_request_body.dart';
import 'config.dart';
import 'enums.dart';
import 'format_util.dart';
import 'logger_utils.dart';

class DBUtils {

  String? databasesPath;
  String? path;
  static const String tbl_feed_history = "tbl_feed_history";
  Database? db;
  static const db_version = 1;


  /** constructor */

  Future<void> init ()async {
    customLogger.d ("DBUtils.init ();");
    databasesPath = await getDatabasesPath();
    path = join(databasesPath!, 'noonting_db.db');

    db = await openDatabase(path!, version: db_version,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE IF NOT EXISTS $tbl_feed_history ("
                  "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"
                  "event TEXT NOT NULL,"
                  "business_tag TEXT NOT NULL);"
          );
        });
  }

  /** 데이타 인서트 */
  Future<void> insertFeedInfo (FeedEvent? event, String? businessTag) async {

    await db!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $tbl_feed_history (event, business_tag) VALUES(?, ?)',
          [FormatUtil.enumToString(event!), businessTag!]);

    });

    String checkQRY = "SELECT COUNT(*) FROM $tbl_feed_history;";
    int? count = Sqflite.firstIntValue(await db!.rawQuery(checkQRY));
    customLogger.d("현재 카운트 ---> $count");
    if (count! > 300) {
      String delQRY = "DELETE FROM $tbl_feed_history WHERE id NOT IN (SELECT id FROM $tbl_feed_history ORDER BY id DESC LIMIT 5);";
      int result = await db!.rawDelete(delQRY);
      customLogger.d("지웠니?? --> $result");
    }
  }

  /** 데이타 삭제 */
  void deleteFeedInfo (int id) {
    //nothing yet;
  }

  /** 데이타 확인 */
  Future<void> checkData () async {
    String qry = "SELECT * FROM $tbl_feed_history ORDER BY id DESC;";
    String tmp = "와우!!! ---------------------------------------\n$qry\n";
    List<Map> list = await db!.rawQuery(qry);

    list.forEach((element) {
      tmp += "${element["id"]}    |   ${element["event"]}   |   ${element["business_tag"]}\n";
    });

    customLogger.d (tmp);

  }

  Future<void> finish () async {
    await db!.close();
  }


  /** 가 보아라... */
  Future<void> saveFeedHistory (FeedEvent event, String businessTag) async {
    await init();
    await insertFeedInfo(event, businessTag);
    if (!kReleaseMode) await checkData();
    await finish ();
  }

  /** 선택된 데이타 보내자 */
  Future<List<FeedHistoryInfoDto>> getFeedHistoryInfo (String userId, {int count = 0}) async {
    await init();
    String qry = count > 0
        ? "SELECT * FROM $tbl_feed_history LIMIT $count ORDER BY id DESC;"
        : "SELECT * FROM $tbl_feed_history ORDER BY id DESC;";

    List<Map> list = await db!.rawQuery(qry);
    List<FeedHistoryInfoDto> parsedList = [];
    list.forEach((element) {
      parsedList.add(FeedHistoryInfoDto(
        media_id: Constants.feed_media_ID,
        event: element['event'],
        user_id: userId,
        business_tag: element['business_tag']
      ));
    });
    await finish ();
    return parsedList;
  }
  
  /** 선택된 데이타 삭제 */
  Future<int> deleteFeedHistoryInfo ({int count = 0}) async {
    await init();
    String qry = count > 0
        ? "DELETE FROM $tbl_feed_history WHERE id NOT IN (SELECT id FROM $tbl_feed_history ORDER BY id DESC LIMIT $count);"
        : "DELETE FROM $tbl_feed_history;";

    int result = await db!.rawDelete(qry);
    await finish ();
    return result;
  }

}