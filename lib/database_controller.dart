import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlController extends GetxController {
  Database? database;
  Future<void> createDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY,'
          ' name TEXT, '
          'value INTEGER,'
          ')',
        );
      },
    );
  }

  Future<void> insertData() async {
    await database?.insert(
      "Test",
      {
        "id": 45,
        "name": "cg",
        "value": 85,
      },
    );

    print('------Done----');
    update();
  }

  Future<void> updateData() async {
    await database!.update("Test", {"value": 100},
        where: "name=?", whereArgs: ["ertyuio"]);
  }

  Future<void> deleteData() async {
    await database!.delete("Test", where: "name=?", whereArgs: ["gyy"]);
  }

  List<Map<String, dynamic>> data = [];
  Future<List<Map<String, dynamic>>> getData() async {
    data = await database!.query(
      'Test',
    );

    print('DATA $data');
    update();
    return data;
  }
}
