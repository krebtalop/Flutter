// random_film_service.dart

import 'dart:math';
import 'database_helper.dart';

class RandomFilmService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<String> getRandomFilm() async {
    List<Map<String, dynamic>> films = await _dbHelper.getFilms();
    if (films.isEmpty) {
      return 'No films available';
    }
    Random random = Random();
    int index = random.nextInt(films.length);
    return films[index]['name'];
  }
}
