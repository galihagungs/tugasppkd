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
          'CREATE TABLE ${ProductQuery.tableName}(${ProductQuery.id} ${ProductQuery.idType}, ${ProductQuery.nama} ${ProductQuery.textType}, ${ProductQuery.category} ${ProductQuery.textType}, ${ProductQuery.quantity} ${ProductQuery.intType})',
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

  Future<List<Map<String, dynamic>>> getProduct({
    required String categoryName,
  }) async {
    final db = await openmyDatabase();
    return db.rawQuery(
      "SELECT * FROM ${ProductQuery.tableName} WHERE ${ProductQuery.category} = '$categoryName'",
    );
  }

  Future<int> deleteProduct({required int id}) async {
    final db = await openmyDatabase();
    return db.delete(ProductQuery.tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateProduct({required Map<String, dynamic> data}) async {
    final db = await openmyDatabase();
    return db.rawUpdate(
      'UPDATE ${ProductQuery.tableName} SET ${ProductQuery.id} = \'${data['id']}\', ${ProductQuery.nama} = \'${data['nama']}\', ${ProductQuery.category} = \'${data['category']}\', ${ProductQuery.quantity} = \'${data['quantity']}\' WHERE ${ProductQuery.id} = ${data['id']}',
    );
  }

  Future<List<Map<String, dynamic>>> searchProduct({
    required String categoryName,
    required String search,
  }) async {
    final db = await openmyDatabase();
    return db.rawQuery(
      "SELECT * FROM ${ProductQuery.tableName} WHERE ${ProductQuery.category} = '$categoryName' AND ${ProductQuery.nama} LIKE '$search%'",
    );
  }
}
