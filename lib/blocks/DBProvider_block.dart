import "dart:io" as io;
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SqLiteDB {
  static final SqLiteDB _instance = new SqLiteDB.internal();

  factory SqLiteDB() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  SqLiteDB.internal();

  /// Initialize DB
  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "myDatabase.db");
    var taskDb =
    await openDatabase(path, version: 1);
    return taskDb;
  }

  /// Count number of tables in DB
  Future countTable() async {
    var dbClient = await db;
    var res =
    await dbClient.rawQuery("""SELECT count(*) as count FROM sqlite_master
         WHERE type = 'table' 
         AND name != 'android_metadata' 
         AND name != 'sqlite_sequence';""");
    return res[0]['count'];
  }

  Future deleteTable(String name) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("DROP TABLE $name");
    return res;
  }


  Future<bool> exists(String table) async {
    try {
     await initDb();
     var res = await _db.rawQuery("SELECT * FROM sqlite_master WHERE type='table' AND name='$table';");
      //if the count is 1, then table exists
     if(res.length>0)
       return true;
     else
       return false;
      } catch (e) {
        return false;
      }
    }

}