import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class RandomFilmService {
  Database? _database;

  Future<void> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'films.db');

    _database = await openDatabase(
      path,
      version: 3, // Versiyonu artırıyoruz
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE films (id INTEGER PRIMARY KEY, name TEXT, category TEXT)',
        );
        await db.execute(
          'CREATE TABLE watched_films (id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE films ADD COLUMN category TEXT');
        }
        if (oldVersion < 3) {
          await db.execute(
            'CREATE TABLE watched_films (id INTEGER PRIMARY KEY, name TEXT)',
          );
        }
      },
    );
  }

  Future<void> addFilm(String filmName, String category) async {
    if (_database == null) await initializeDatabase();
    await _database!.insert('films', {'name': filmName, 'category': category});
  }

  Future<void> updateFilms(List<Map<String, String>> newFilms) async {
    if (_database == null) await initializeDatabase();
    await _database!.delete('films');
    Batch batch = _database!.batch();
    for (var film in newFilms) {
      batch.insert(
          'films', {'name': film['name']!, 'category': film['category']!});
    }
    await batch.commit();
  }

  Future<List<String>> getAllFilms() async {
    if (_database == null) await initializeDatabase();
    List<Map<String, dynamic>> maps = await _database!.query('films');
    List<String> films = List.generate(maps.length, (i) => maps[i]['name']);
    return films;
  }

  Future<List<String>> getFilmsByCategory(String category) async {
    if (_database == null) await initializeDatabase();
    List<Map<String, dynamic>> maps = await _database!.query(
      'films',
      where: 'category = ?',
      whereArgs: [category],
    );
    List<String> films = List.generate(maps.length, (i) => maps[i]['name']);
    return films;
  }

  Future<String> getRandomFilm({String? category}) async {
    if (_database == null) await initializeDatabase();
    List<String> films;
    if (category != null) {
      films = await getFilmsByCategory(category);
    } else {
      films = await getAllFilms();
    }
    if (films.isEmpty) {
      return 'Bu kategoride film bulunamadı.';
    }
    Random random = Random();
    int index = random.nextInt(films.length);
    return films[index];
  }

  Future<void> markAsWatched(String filmName) async {
    if (_database == null) await initializeDatabase();
    await _database!.insert('watched_films', {'name': filmName});
  }

  Future<List<String>> getWatchedFilms() async {
    if (_database == null) await initializeDatabase();
    List<Map<String, dynamic>> maps = await _database!.query('watched_films');
    List<String> films = List.generate(maps.length, (i) => maps[i]['name']);
    return films;
  }
}
