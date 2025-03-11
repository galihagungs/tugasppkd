import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ui_new/local/query/productLocalQuery.dart';

class DbHelper {
  Future<Database> openmyDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'ui_store.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE ${ProductQuery.tableName}(${ProductQuery.id} ${ProductQuery.idType}, ${ProductQuery.nama} ${ProductQuery.textType}, ${ProductQuery.quantity} ${ProductQuery.intType})',
        );
      },
    );
  }

  Future<void> insertProduct({
    required String titleData,
    required Map<String, dynamic> data,
  }) async {
    final db = await openmyDatabase();
    db.insert(titleData, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getProduct() async {
    final db = await openmyDatabase();
    return db.rawQuery("SELECT * FROM ${ProductQuery.tableName}");
  }
}
