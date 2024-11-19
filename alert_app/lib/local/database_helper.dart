import 'package:alert_app/models/sensor_response.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('my_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    Create table if not exists sensors(
    id integer primary key autoincrement,
    topic text not null,
    location text not null
    )

''');
//     await db.execute('''
//     create table if not exists users(
//     id integer primary key autoincrement,
//     address text,
//     phoneNumber text,
//     email text,
//     name text
//     )
// ''');
  }

  Future<void> checkTableStructure() async {
    try {
      final db = await database;
      await db.rawQuery("PRAGMA table_info(sensors)");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteAllDataSensors() async {
    final Database db = await instance.database;
    await db.rawDelete('Delete from sensors');
  }

  Future<int> insertSensor(SensorResponse sensor) async {
    final Database db = await instance.database;

    return await db.insert('sensors', sensor.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllSensors() async {
    final Database db = await instance.database;
    return await db.query('sensors');
  }
}
