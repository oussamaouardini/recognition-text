import 'package:text_recognition_app/blocks/DBProvider_block.dart';

class ScanResult{
  int id;
  String textScanned;
  DateTime dateTime;
  ScanResult(this.id, this.textScanned);

  Future createResultsTable() async {
    var dbScan = await SqLiteDB().db;
    var res = await dbScan.execute("""
      CREATE TABLE ScanResult(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        textScanned TEXT,
        dateTime TEXT
      )""");
    return res;
  }

  // ignore: non_constant_identifier_names
  static Future save(String name, String text) async {
    /// Scan data
    dynamic scanResult = {
      "name": "$name",
      "textScanned": "$text",
      "dateTime":DateTime.now().toString()
    };
    /// Adds Results to table
    final dbClient = await SqLiteDB().db;
    int res = await dbClient.insert("ScanResult", scanResult);
    return res;
  }
  static Future update(int id,String newName) async {

    /// Adds Results to table
    final dbClient = await SqLiteDB().db;
    final res = await dbClient.rawQuery("UPDATE ScanResult SET name='$newName' where id=$id");
    return res;
  }
  /// Get all Results using raw query
  Future getAll() async {
    var scanResults = await SqLiteDB().db;
    final res = await scanResults.rawQuery("SELECT * FROM ScanResult");
    return res;
  }
  /// delete a Saved Scan using raw query
  static Future delete(int id) async {
    var scanResults = await SqLiteDB().db;
    final res = await scanResults.rawQuery("DELETE FROM ScanResult WHERE id=$id");
    return res;
  }
}