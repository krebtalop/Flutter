import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'films.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE films(id INTEGER PRIMARY KEY, name TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getFilms() async {
    Database db = await database;
    return await db.query('films');
  }

  Future<void> insertFilm(String filmName) async {
    Database db = await database;
    await db.insert('films', {'name': filmName});
  }

  Future<void> deleteAllFilms() async {
    Database db = await database;
    await db.delete('films');
  }
}
