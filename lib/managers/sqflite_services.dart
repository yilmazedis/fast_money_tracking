// import 'dart:async';
// import 'package:path/path.dart' as p;
// import 'package:sqflite/sqflite.dart';
// import '../models/item.dart';
//
// abstract class DB {
//   static Database? _db;
//   static int get _version => 1;
//
//   static Future<void> init() async {
//     if (_db != null) {
//       return;
//     }
//     try {
//       var databasesPath = await getDatabasesPath();
//       String path = p.join(databasesPath, 'money_crud.db');
//       _db = await openDatabase(path, version: _version, onCreate: onCreate);
//     } catch (ex) {
//       print(ex);
//     }
//   }
//
//   static onCreate(Database db, int version) {
//     return db.execute(
//         'CREATE TABLE input (id TEXT PRIMARY KEY, type TEXT, amount REAL, category INTEGER, description TEXT, date TEXT)');
//   }
//
//   static Future<List<Item>> inputModelList() async {
//     List<Map<String, dynamic>> inputList = await _db!.query('input');
//     return inputList.map((item) => Item.fromMap(item)).toList();
//   }
//
//   static Future<int> insert(Item model) async => await _db!.insert(
//     'input',
//     model.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
//
//   static Future<int> update(Item model) async => await _db!.update(
//     'input',
//     model.toMap(),
//     where: 'id = ?',
//     whereArgs: [model.id],
//   );
//
//   static Future<int> delete(String id) async =>
//       await _db!.delete('input', where: 'id = ?', whereArgs: [id]);
//
//   static Future<int> deleteAll () async =>
//       await _db!.delete('input');
// }
