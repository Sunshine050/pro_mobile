import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'counter.db');
    print('Database path: $path'); // ตรวจสอบเส้นทางฐานข้อมูล
    try {
      Database db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          print('Creating table...');
          await db.execute('''CREATE TABLE counter(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            count INTEGER
          )''');
          await db.insert('counter', {'count': 0});
        },
      );
      print('Database created');
      return db;
    } catch (e) {
      print('Error creating database: $e');
      throw Exception('Error creating database');
    }
  }

  Future<int> incrementCounter() async {
    final db = await database;
    var res = await db.rawUpdate('''UPDATE counter SET count = count + 1''');
    return res;
  }

  Future<int?> getCounter() async {
    final db = await database;
    List<Map> result = await db.query('counter');
    return result.isNotEmpty ? result.first['count'] as int : null;
  }

  Future<void> resetCounter() async {
    final db = await database;
    await db.update('counter', {'count': 0});
  }

  Future<void> saveCounter(int count) async {
    
    final db = await database;
    await db.update(
      'counter',
      {'count': count},
      where: 'id = ?',
      whereArgs: [1], // ใช้ ID ที่เรารู้จัก
    );
  }
}
